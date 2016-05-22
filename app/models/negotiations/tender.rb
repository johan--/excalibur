class Tender < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include RefreshSlug
  include Pacecar
  extend FriendlyId
  protokoll :ticker, :pattern => "PRO%y####%m"
  friendly_id :slug_candidates, use: :slugged
  monetize :price_sens
  acts_as_commentable
  acts_as_paranoid
  is_impressionable
  
  belongs_to :tenderable, polymorphic: true  
  belongs_to :starter, polymorphic: true  
  has_many :bids
  has_many :tender_transitions
  has_many :comments, as: :commentable
  
  # delegate :starter_name, :progress, :price, :ticker, to: :bid, prefix: true, allow_nil: true

  attr_accessor :asset_id, :asset

  serialize :details, HashSerializer
  store_accessor :details, 
                 :unit, :draft, :participate, :state,  :pushed

  attr_wannabe_bool :draft, :participate, :pushed

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
  
  # validates_presence_of :aqad, :category, :tenderable, :seed_capital, :starter

  before_create :set_default_values!
  after_create :refresh_friendly_id!
  after_save :connect_with_bid
  # after_update  :touch_bid!
  after_touch :set_state!

  # Pagination
  paginates_per 30

  def to_partial_path
    'trading/tenders/tender'
  end

  def target
    (price * volume)
  end

  def fulfilled?
    return true if check_contribution == self.target
    return false if check_contribution != self.target
  end

  scope :open, -> { where("tenders.details->>'state' = :type", type: "open")  }
  scope :completed, -> { where( "tenders.details->>'state' = :type", type: "success")  }  
  scope :offering, -> { where(category: "fundraising") }
  scope :housing, -> { where(tenderable_type: 'House') }
  scope :trading, -> { where(category: "trading") }
  scope :published, -> { where("tenders.details->>'draft' = :type", type: "no") }

  def access_granted?(user)
    if user == self.starter || user.admin? then true else false end
  end

  def check_contribution
    bids.sum(:volume) * price
  end

  def shares_left
    volume - bids.sum(:volume)
  end

  def expire_stock!
    self.tenderable.update(
      tradeable: false, expired: 'yes', expired_at: Date.today)
  end

  def progress
    check_contribution / target * 100
  end

  def to_window_closed
    ((created_at.to_date + 90.days) - Date.today).to_i
  end

# Transitions
  def reopening
    self.transition_to!(:open)
  end

  def closing
    self.transition_to!(:closed)
  end

  def running
    self.transition_to!(:running)
  end

  def completing
    self.transition_to!(:success)
  end
  def dropping
    self.transition_to!(:failed)
  end  
####

  def tender_owner?(user)
    return true if self.starter == user
    return false if self.starter != user
  end

  def starter_name
    starter.name
  end

private
  def set_default_values!
    self.unit = 'ownership'
    self.state = 'open' if self.state.blank?
    self.draft = 'no' if self.draft.blank?
  end

  def create_musharaka_bid(volume)
    if self.category == 'fundraising' && self.participate?
      Bid.create(tender: self, volume: volume, 
        bidder: self.starter, client: 'yes')
    end
  end

  def connect_with_bid
    vol = self.seed_capital.to_i * 10

    if self.bids.count == 0
      create_musharaka_bid(vol)
    else
      refresh_musharaka_bid(vol) if details_changed?
    end
  end

  def refresh_musharaka_bid(volume)
    self.bids.client.first.update(volume: volume)
  end

  def set_state!
    if self.fulfilled?
      self.closing unless self.state == 'closed'
    else
      self.reopening unless self.state == 'open'
    end
  end

  def self.transition_class
    TenderTransition
  end

  def self.initial_state
    :open
  end

  def slug_candidates
    [ :ticker, [:ticker, :tenderable_name]  ]
  end

  def tenderable_name
    self.starter.name
  end

  def should_generate_new_friendly_id?
    ticker_changed? || super
  end  
end