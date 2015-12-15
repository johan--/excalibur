class Tender < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include ProfitMargin
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # include PublicActivity::Model
  # tracked
  monetize :target_sens
  monetize :contributed_sens

  HOUSE = ["rumah tunggal", "rumah koppel/gandeng", "town house"]
  APARTMENT = "rumah susun/flat"

  belongs_to :tenderable, polymorphic: true  
  has_many :bids
  has_one  :deal
  has_many :tender_transitions
  
  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :category, 
                 :summary, :barcode, :tenderable_name

  serialize :details, HashSerializer
  store_accessor :details, 
                 :tangible, :use_case, :intent, :aqad, :aqad_code,
                 :address, :area, 
                 :price, :maturity, :margin, :own_capital,
                 :published
  attr_wannabe_bool :open, :published

# Statesman stuffs
  # Initialize the state machine
  def state_machine
    @state_machine ||= TenderStateMachine.new(
      self, transition_class: TenderTransition)
  end
  # Optionally delegate some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, 
         :current_state, to: :state_machine
# ##################################
  
  validates_presence_of :aqad, :price, :address

  before_create :set_default_values!
  before_save :set_target!, :set_margin!
  after_touch :update_contribution!, :set_state!

  # Pagination
  paginates_per 30

  def house?
    true if tangible.in?(HOUSE)
  end

  def apartment?
    true if tangible.in?(APARTMENT)
  end

  def fulfilled?
    true if self.contributed == self.target
  end

  def self.categories
    %w(Institusi Bisnis Individu)
  end

  scope :open, -> { 
    where("tenders.properties->>'open' = :true", true: "true") 
  }
  scope :qualified, -> { where(state: "qualified") }
  scope :with_aqad, ->(aqad) { 
    where("tenders.details->>'aqad' = :type", type: "#{aqad}") 
  }

  def access_granted?(user)
    if self.tenderable_type == 'User'
      self.tender_owner?(user)
    else
      self.member_of_tenderable?(user)
    end
  end

  def tender_owner?(user)
    if self.tenderable == user
      return true
    else
      return false
    end      
  end

  def member_of_tenderable?(user)
    if tenderable.team.has_as_member?(user)
      return true
    else
      return false
    end
  end

  def funding_progress
    (contributed / target) * 100
  end

  def shares_remaining
    ((target - contributed) / price_per_share).round(0)
  end

  def price_per_share
    target / total_share
  end

  def total_share
    1000
  end

# Transitions
  def processing
    self.transition_to!(:processing)
  end

  def qualifying
    self.transition_to!(:qualified)
  end

  def completing
    self.transition_to!(:complete)
  end
####

  def set_tangible_type
    if self.house?
      return "Rumah"
    elsif self.apartment?
      return "Apartemen"
    end
  end


private
  def set_default_values!
    self.state = 'fresh'
    self.barcode = "##{SecureRandom.hex(3)}"
    self.tenderable_name = self.tenderable.name
    self.open = true
  end

  def set_target!
    @price = self.price.to_i
    @own_capital = self.own_capital.to_i

    if self.aqad == 'murabahah'
      self.target = @price
    elsif self.aqad == 'musyarakah'
      capital = @price * @own_capital / 100
      self.target = @price - capital
    end
  end

  def set_margin!
    if self.aqad == 'murabahah'
      self.margin = selling_margin(maturity)
    elsif self.aqad == 'musyarakah'
      property = "Rumah" if self.house?
      property = "Apartemen" if self.apartment?

      self.margin = capitalization_rate(maturity, property)
    end
  end

  def slug_candidates
    [ 
      :barcode,
      [:barcode, :tenderable_name]
    ]
  end

  def update_contribution!
    update(contributed: check_contribution)
  end

  def check_contribution
    value = self.bids.map{ |bid| bid.contribution }.compact.sum
    return value
  end

  def self.transition_class
    TenderTransition
  end

  def self.initial_state
    :fresh
  end

  def set_state!
    
    unless self.state == "qualified"
        self.qualifying if self.fulfilled? 
    else  
      self.processing unless self.state == "processing"
    end

  end

end