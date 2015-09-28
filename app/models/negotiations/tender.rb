class Tender < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  include PublicActivity::Model
  tracked

  belongs_to :tenderable, polymorphic: true  
  
  has_many :bids

# Statesman stuffs
  has_many :tender_transitions
  # Initialize the state machine
  def state_machine
    @state_machine ||= TenderStateMachine.new(
      self, transition_class: TenderTransition)
  end
  # Optionally delegate some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, 
         :current_state, to: :state_machine
# ##################################

  monetize :target_sens
  monetize :contributed_sens

  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :category, :status_quo,
                 :summary, :barcode, :tenderable_name

  serialize :details, HashSerializer
  store_accessor :details, 
                 :tangible, :use_case, :intent, :aqad, :aqad_code,
                 :address, :price

  validates_presence_of :aqad, :summary#, :target, :contributed

  before_create :set_default_values!
  # before_save :calculate_owner_capital!
  after_touch :update_contribution!

  def self.categories
    %w(Institusi Bisnis Individu)
  end

  scope :open, -> { 
    where("tenders.properties->>'open' = :true", true: "true") 
  }
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

private
  def set_default_values!
    self.state = 'fresh'
    self.barcode = "##{SecureRandom.hex(3)}"
    self.tenderable_name = self.tenderable.name
    self.open = true
  end

  def slug_candidates
    [ 
      :barcode,
      [:tenderable_name, :barcode]
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

  def calculate_owner_capital!
    self.own_capital = self.price - self.target 
  end
end