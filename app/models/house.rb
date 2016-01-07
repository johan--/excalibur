class House < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  monetize :price_sens

  has_many :tenders
  belongs_to :publisher, polymorphic: true

  HOUSE = ["rumah tunggal", "rumah gandeng", "town house"]
  APARTMENT = ["apartemen, rumah susun, flat"]

  serialize :details, HashSerializer
  store_accessor :details, 
                 :barcode, :unit_type

  # before_create :set_default_values!


  def house?
    true if self.type.in?(HOUSE)
  end

  def apartment?
    true if self.type.in?(APARTMENT)
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
  #   self.title = "#{self.category.titleize} #{self.id} #{self.city}"
  # end
end