class House < ActiveRecord::Base
  extend FriendlyId
  include RefreshSlug
  include WannabeBool::Attributes
  protokoll :ticker, :pattern => "RUM#y%m####"
  friendly_id :slug_candidates, use: :slugged
  monetize :price_sens
  acts_as_paranoid
  is_impressionable
  
  belongs_to :publisher, polymorphic: true
  has_many :stocks
  has_one :occupancy
  has_many :comments, as: :commentable
  # has_many :tenders, through: :stocks
  has_attachments :photos, maximum: 6

  cattr_accessor :form_steps do
    %w(place characteristics pictures situations)
  end

  HOUSE = ["rumah tunggal", "rumah gandeng", "town house"]
  APARTMENT = ["apartemen, rumah susun, flat"]


  serialize :details, HashSerializer
  store_accessor :details, 
                 :category, :bedrooms, :bathrooms, :level, 
                 :greenery, :garages, :property_size, :lot_size
  serialize :location, HashSerializer
  store_accessor :location, 
                 :address, :address_was, :city, :complex,
                 :province, :country
  serialize :condition, HashSerializer
  store_accessor :condition,
                 :form_step, :state, :for_sale, :for_rent, 
                 :vacant, :anno, :inspected,
                 :mortgage_period_left, :outstanding_mortgage

  attr_wannabe_bool :for_sale, :for_rent, :vacant, :inspected
  geocoded_by :full_street_address 

  # with_options if: -> { required_for_step?(:characteristics) } do |step|
  #   step.validates :bedrooms, presence: true
  #   step.validates :bathrooms, presence: true
  #   step.validates :level, presence: true
  #   step.validates :garages, presence: true
  #   step.validates :property_size, presence: true
  #   step.validates :lot_size, presence: true
  # end

  before_create :set_default_values!
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_create :refresh_friendly_id!, :create_relation!
  # after_update :refresh_tenders

  scope :vacancy, -> { 
    where("houses.details->>'vacant' = 'yes'") 
  }

  def full_street_address
    "#{self.address}, #{self.city}, #{self.province}, #{self.country}"
  end

  def address_changed?
    return true if self.address != self.address_was
    return false if self.address == self.address_was
  end

  def initial_stock
    self.stocks.first
  end

  def placeholder
    "//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_175,w_175/v1452508512/asset/2000px-House_Silhouette.png"
  end

  def display_picture
    photos.first
  end

  def input_unfinished?
    if form_step != 'done' then true else false end
  end

  def house_owner
    publisher.name if self.occupancy.holder.nil? 
    # self.occupancy.holder.name unless self.occupancy.holder.nil?
  end

  def self.access_granted(user)
    if user == self.publisher then true else false end
  end

  def states_of_house
    ["for sale", "vacant", "for rent"]
  end

  def price_ticker
      price_sens / 100000000
  end

  def slug_candidates
    [:ticker]
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

private
  def set_default_values!
    self.country = 'indonesia'
    self.state = 'pending' if self.state.nil?
    self.address_was = self.address
    self.for_rent = 'no'
    self.avatar = 'first'
  end

  # def check_address
  #   if self.address
  # end

  def refresh_tenders
    self.tenders.map{ |tender| tender.touch }
  end

  def create_relation!
    if self.vacant? 
      create_stock!
    else
      create_occupancy!
      create_stock! #if self.for_sale
    end
  end

  def create_stock!
    Stock.create(
      holder: self.publisher, house: self, initial: 'yes',
      price: self.price/1000, volume: 1000
    )
  end

  def create_occupancy!
    Occupancy.create(
      holder: self.publisher, house: self,
      rental: false, started_at: Date.today,
      annual_rental: self.price * 0.05, tradeable: true
    )
  end
end