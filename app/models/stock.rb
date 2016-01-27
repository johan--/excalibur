class Stock < ActiveRecord::Base
  extend FriendlyId  
  include WannabeBool::Attributes
  include RefreshSlug
  friendly_id :slug_candidates, use: :slugged
  protokoll :ticker, :pattern => "STO%y####%m"
  monetize :price_sens

  belongs_to :house
  belongs_to :holder, polymorphic: true
  has_many :tenders, as: :tenderable

  delegate :ticker, to: :house, prefix: true

  serialize :details, HashSerializer
  store_accessor :details, 
                 :dummy, :initial, :state, :expired

  attr_wannabe_bool :dummy, :initial, :expired

  after_create :refresh_friendly_id!
  
  scope :initials, -> { 
    where("stocks.details->>'initial' = :type", type: "yes") 
  }
  scope :tradeables, -> { where(tradeable: true) }


  def stock_image
    house.display_picture
  end

  def worth
    price * volume
  end

private

  def slug_candidates
    [:ticker]
  end


end