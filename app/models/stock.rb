class Stock < ActiveRecord::Base
  extend FriendlyId  
  include WannabeBool::Attributes
  include RefreshSlug
  friendly_id :slug_candidates, use: :slugged
  protokoll :ticker, :pattern => "STO%y####%m"
  monetize :price_sens
  acts_as_nested_set

  belongs_to :house
  belongs_to :holder, polymorphic: true
  has_many :tenders, as: :tenderable
  has_many :acquisitions, as: :acquireable

  delegate :ticker, :display_picture, to: :house, prefix: true

  serialize :details, HashSerializer
  store_accessor :details, 
                 :dummy, :initial, :state, :expired, 
                 :expired_at, :history

  attr_wannabe_bool :dummy, :initial, :expired

  before_create :set_defaults!
  after_create  :refresh_friendly_id!
  # after_touch   :check_condition


  scope :initial, -> { 
    where("stocks.details->>'initial' = :type", type: "yes").first
  }
  scope :tradeables, -> { where(tradeable: true) }


  def stock_image
    house.display_picture
  end

  def worth
    price * volume
  end

  def should_be_expired?
    total_traded = self.tenders.completed.map{ |t| t.volume }.compact.sum
    return true if self.volume == total_traded
    return false if self.volume != total_traded
  end


private
  def slug_candidates
    [:ticker]
  end

  def set_defaults!
    self.category = 'ownership'
    self.expired = 'no'
    self.tradeable = true
    self.state = 'full'
  end
end