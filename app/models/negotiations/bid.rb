class Bid < ActiveRecord::Base
  include WannabeBool::Attributes
  include Statesman::Adapters::ActiveRecordQueries
  include RefreshSlug
  extend FriendlyId
  protokoll :ticker, :pattern => 'BID%m####'
  friendly_id :slug_candidates, use: :slugged
  acts_as_paranoid

  belongs_to :bidder, polymorphic: true
  belongs_to :tender
  has_many   :bid_transitions
  has_many   :acquisitions
  has_one    :invoice, as: :invoiceable
  delegate :paid?, :payments, to: :invoice, prefix: true
  monetize :price_sens

  serialize :details, HashSerializer
  store_accessor :details, 
                 :client, :draft, :state, :message,
                 :last_volume, :installments

  attr_wannabe_bool :draft, :client

# Statesman stuffs
  # Initialize the state machine
  def state_machine
    @state_machine ||= BidStateMachine.new(
      self, transition_class: BidTransition)
  end
  # Optionally delegate some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, 
         :current_state, to: :state_machine
# ##################################

  validates_presence_of :price, :volume
  validates_associated :tender

  before_create :set_default_values!
  after_create :refresh_friendly_id!
  after_save  :touch_tender!, if: ->(obj){ obj.volume_changed? }
  after_touch :change_state

  scope :usermade, -> { where(bidder_type: 'User') }
  scope :client, -> { where("bids.details->>'client' = :type", type: "yes")  }
  scope :completed, -> { where(
    "bids.details->>'state' = :type", type: "success")  
  }

  def to_partial_path
    'trading/bids/bid'
  end

  def bidder?(user)
    return true if self.bidder == user
  end
  
  def has_been_paid?
    if self.invoice.present? && self.invoice_paid?
      return true
    else
      return false
    end
  end

  def contribution
    price * volume
  end

  def transfer_ownership!
    @tenderable = self.tender.tenderable
    @stock = Stock.create(holder: self.bidder, house: @tenderable.house,
      initial: 'no', price: @tenderable.price, volume: volume)
    @stock.move_to_child_of(@tenderable)
    self.acquisitions.create(acquireable: @stock)
  end

  def process_occupancy!
    @house = self.tender.tenderable.house
    @occupancy =  Occupancy.create(
        holder: self.bidder, house: @house, rental: true, 
        started_at: Date.today, annual_rental: @house.annual_rental, 
        tradeable: true
    )
    self.acquisitions.create(acquireable: @occupancy)
  end

  def approving!
    self.state_machine.transition_to!(:success) unless self.state == 'success'
  end

  def request_funding
    self.create_invoice(recipient: self.bidder, amount: contribution, 
      deadline: 2.days.from_now, category: "funding")    
  end

private
  def set_default_values!
	  self.state = "pending" if self.state.nil?
    self.draft = "no" if self.draft.nil?
    self.price = self.tender.price
  end

  def touch_tender!
    self.tender.touch
  end

  def slug_candidates
    [:ticker]
  end

  def self.transition_class
    BidTransition
  end

  def self.initial_state
    :pending
  end

  def change_state
    if self.has_been_paid?
      self.approving!
    else
    end
  end

  def should_generate_new_friendly_id?
    ticker_changed? || super
  end
end