class House < ActiveRecord::Base
  extend FriendlyId
  include RefreshSlug
  include WannabeBool::Attributes
  protokoll :ticker, :pattern => "RUM#y%m####"
  friendly_id :slug_candidates, use: :slugged
  monetize :price_sens

  belongs_to :publisher, polymorphic: true
  has_many :stocks
  has_one :occupancy
  # has_many :tenders, through: :stocks
  has_attachments :photos, maximum: 6

  HOUSE = ["rumah tunggal", "rumah gandeng", "town house"]
  APARTMENT = ["apartemen, rumah susun, flat"]

  serialize :details, HashSerializer
  store_accessor :details, 
                 :category, :for_sale, :for_rent, :vacant, :anno, :country,
                 :bedrooms, :bathrooms, :level, :garages, 
                 :greenery, :property_size, :lot_size

  attr_wannabe_bool :for_sale, :for_rent, :vacant
  geocoded_by :address   # can also be an IP address

  # before_create :set_default_values!
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_create :refresh_friendly_id!, :create_stock!
  # after_update :refresh_tenders

  scope :vacancy, -> { 
    where("houses.details->>'vacant' = 'yes'") 
  }

  def states_of_house
    ["for sale", "vacant", "for rent"]
  end


  def price_ticker
      price_sens / 100000000
  end

  def slug_candidates
    [:ticker]
  end

private
  def refresh_tenders
    self.tenders.map{ |tender| tender.touch }
  end

  def create_stock!
    Stock.create(
      holder: self.publisher,
      house: self,
      category: "ownership",
      initial: 'yes',
      tradeable: true, 
      price: self.price/1000, volume: 1000,
      state: "full"
    )
  end

end