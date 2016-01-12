class Tender < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include ProfitMargin
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # include PublicActivity::Model
  # tracked
  monetize :target_sens

  belongs_to :house
  belongs_to :tenderable, polymorphic: true  
  has_many :bids
  has_many :tender_transitions
  
  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :broadcast, :draft,
                 :summary, :barcode, :tenderable_name

  serialize :details, HashSerializer
  store_accessor :details, 
                 :shares, :use_case, :aqad, :aqad_code,
                 :margin, :own_capital, :unit
  attr_wannabe_bool :broadcast, :draft

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
  
  # validates_presence_of :aqad, :price, :address

  before_create :set_default_values!
  # before_save :set_target!, :set_margin!
  after_touch :set_state!

  # Pagination
  paginates_per 30


  def fulfilled?
    true if check_contribution == self.target
  end

  def self.categories
    %w(Penggalangan Penjualan)
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
    (check_contribution / target) * 100
  end

  def shares_remaining
    ((target - check_contribution) / price_per_share).round(0)
  end

  def price_per_share
    target / shares
  end

  def total_share
    1000
  end

# Transitions
  def reopen
    self.transition_to!(:open)
  end

  def closing
    self.transition_to!(:closed)
  end

  def completing
    self.transition_to!(:success)
  end
  def dropping
    self.transition_to!(:dropped)
  end  
####



private
  def set_default_values!
    self.state = 'open'
    self.barcode = "##{SecureRandom.hex(3)}"
    self.tenderable_name = self.tenderable.name
    self.broadcast = 'true'
    self.shares = total_share
  end

  def set_target!
    # @price = self.price.to_i
    # @own_capital = self.own_capital.to_i

    # if self.aqad == 'murabahah'
    #   self.target = @price
    # elsif self.aqad == 'musyarakah'
    #   capital = @price * @own_capital / 100
    #   self.target = @price - capital
    # end
  end

  def set_margin!
    # if self.aqad == 'murabahah'
    #   self.margin = selling_margin(maturity)
    # elsif self.aqad == 'musyarakah'
    #   property = "Rumah" if self.house.category == 'Rumah'
    #   property = "Apartemen" if self.category == 'Apartemen'

    #   self.margin = capitalization_rate(maturity, property)
    # end
  end

  def slug_candidates
    [ 
      :barcode,
      [:barcode, :tenderable_name, ]
    ]
  end

  def check_contribution
    value = self.bids.map{ |bid| bid.contribution }.compact.sum
    return value
  end

  def self.transition_class
    TenderTransition
  end

  def self.initial_state
    :open
  end

  def set_state!
    
    unless self.state == "qualified"
        self.qualifying if self.fulfilled? 
    else  
      self.processing unless self.state == "processing"
    end

  end

end