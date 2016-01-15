class House < ActiveRecord::Base
  extend FriendlyId
  include RefreshSlug
  include WannabeBool::Attributes
  protokoll :ticker, :pattern => "RUM#y%m%d####"
  friendly_id :slug_candidates, use: :slugged
  monetize :price_sens

  belongs_to :publisher, polymorphic: true
  has_many :tenders
  has_attachments :photos, maximum: 6

  HOUSE = ["rumah tunggal", "rumah gandeng", "town house"]
  APARTMENT = ["apartemen, rumah susun, flat"]

  serialize :details, HashSerializer
  store_accessor :details, 
                 :for_sale, :for_rent, :vacant, :anno, :country,
                 :bedrooms, :bathrooms, :level, :garages, 
                 :greenery, :property_size, :lot_size

  attr_wannabe_bool :for_sale, :for_rent, :vacant
  geocoded_by :address   # can also be an IP address

  # before_create :set_default_values!
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_create :refresh_friendly_id!
  after_update :refresh_tenders

  scope :vacancy, -> { 
    where("houses.details->>'vacant' = 'yes'") 
  }

  def states_of_house
    ["for sale", "vacant", "for rent"]
  end


  def price_ticker
      price_sens / 100000000
  end

  # def set_tangible_type
  #   if self.unit_type.in?(HOUSE)
  #     return "rumah"
  #   elsif self.unit_type.in?(APARTMENT)
  #     return "apartemen"
  #   end
  # end

  def slug_candidates
    [:ticker]
  end

private
  def refresh_tenders
    self.tenders.map{ |tender| tender.touch }
  end

end