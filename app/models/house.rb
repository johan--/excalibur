class House < ActiveRecord::Base
  extend FriendlyId
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
                 :barcode, :unit_type, :bedrooms, :bathrooms,
                 :level, :garages, :greenery, :property_size, :lot_size,
                 :structure_type, :anno, :country

  geocoded_by :address   # can also be an IP address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # before_create :set_default_values!
  # before_save :mark_it_down!

  def states_of_house
    ["for sale", "available", "for rent"]
  end

  def house?
    true if self.type.in?(HOUSE)
  end

  def apartment?
    true if self.type.in?(APARTMENT)
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

  # def set_barcode
  #   cat = "APT" if set_tangible_type == 'apartemen'
  #   cat = "RMH" if set_tangible_type == 'rumah'

  #   return "#{cat} #{id} #{city}"
  # end

  # def set_default_values!
  #   self.state = ""
  # end

  # def mark_it_down!
  #   MarkdownWriter.update_html(self)
  # end
  def slug_candidates
    [:ticker]
  end
end