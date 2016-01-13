class Tender < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include ProfitMargin
  extend FriendlyId
  protokoll :ticker, :pattern => "PRO%y%m%d####"
  friendly_id :slug_candidates, use: :slugged
  # include PublicActivity::Model
  # tracked
  monetize :price_sens

  belongs_to :house
  belongs_to :tenderable, polymorphic: true  
  has_many :bids
  has_many :tender_transitions
  
  serialize :details, HashSerializer
  store_accessor :details, 
                 :state, :aqad_code, :margin, :unit, :draft, :message,
                 :seed_capital

  attr_wannabe_bool :draft

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
  
  validates_presence_of :price, :volume, :aqad

  before_create :set_default_values!
  # before_save :set_price!, :set_margin!
  after_touch :set_state!

  # Pagination
  paginates_per 30

  def target
    price * volume
  end

  def fulfilled?
    return true if check_contribution == self.target
    return false if check_contribution != self.target
  end

  def categories
    %w(housepurchase sharepurchase houserent)
  end

  scope :open, -> { where(state: "open") }
  # scope :with_aqad, ->(aqad) { 
  #   where("tenders.details->>'aqad' = :type", type: "#{aqad}") 
  # }

  def access_granted?(user)
    if self.tenderable_type == 'User'
      self.tender_owner?(user)
    else
      self.member_of_tenderable?(user)
    end
  end

  def tender_owner?(user)
    return true if self.tenderable == user
    return false if self.tenderable != user
  end

  def member_of_tenderable?(user)
    return true if tenderable.team.has_as_member?(user)
    return false if !tenderable.team.has_as_member?(user)
  end

  def funding_progress
    (check_contribution / price) * 100
  end

  def shares_left
    volume - self.bids.map{ |bid| bid.volume }.compact.sum
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
    self.state = 'open' if self.state.nil?
    self.draft = 'no' if self.draft.nil?
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

  def check_contribution
    value = self.bids.map{ |bid| bid.contribution }.compact.sum
    return value
  end

  def set_state!
    if self.fulfilled?
      self.closing unless self.state == "closed"
    else
      self.reopening
    end
  end

  def self.transition_class
    TenderTransition
  end

  def self.initial_state
    :open
  end

  def slug_candidates
    [:ticker]
  end
end