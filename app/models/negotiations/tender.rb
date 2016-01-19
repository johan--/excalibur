class Tender < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include ProfitMargin
  include RefreshSlug
  extend FriendlyId
  protokoll :ticker, :pattern => "PRO%y####%m"
  friendly_id :slug_candidates, use: :slugged
  monetize :price_sens
  acts_as_commentable
  acts_as_paranoid

  belongs_to :house
  belongs_to :tenderable, polymorphic: true  
  has_many :bids
  has_many :tender_transitions
  
  attr_accessor :funding_target

  serialize :details, HashSerializer
  store_accessor :details, 
                 :state, :aqad_code, :layman_terms,
                 :margin, :unit, :draft, :message,
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
  
  validates_presence_of :aqad, :category, :house

  before_create :set_default_values!
  after_create :refresh_friendly_id!
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

  def check_contribution
    value = self.bids.real.map{ |bid| bid.contribution }.compact.sum
    return value
  end

  def shares_left
    volume - self.bids.map{ |bid| bid.volume }.compact.sum
  end

# Transitions
  def reopening
    self.transition_to!(:open)
  end

  def closing
    self.transition_to!(:closed)
  end

  def completing
    self.transition_to!(:success)
  end
  def dropping
    self.transition_to!(:failed)
  end  
####

  def tender_discussion

  end


private
  def set_default_values!
    set_tender_unit!
    self.volume = 1000 if self.volume.nil?
    self.price = self.house.price / 1000 if self.price.nil?
    self.state = 'open' if self.state.blank?
    self.draft = 'no' if self.draft.blank?
    self.layman_terms = 'credit sale' if self.aqad == 'murabaha'
    self.layman_terms = 'co-ownership' if self.aqad == 'musharaka'
  end

  def set_tender_unit!
    self.unit = 'revenue shares' if self.aqad == 'murabaha'
    self.unit = 'ownership shares' if self.aqad == 'musharaka'
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

  def set_state!
    if self.fulfilled?
      self.closing unless self.state == 'closed'
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
    [
      :ticker, 
      [:ticker, :tenderable_name]
    ]
  end

  def tenderable_name
    self.tenderable.name
  end
end