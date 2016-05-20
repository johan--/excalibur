class House < ActiveRecord::Base
  extend FriendlyId
  include WannabeBool::Attributes
  protokoll :ticker, :pattern => '%y####%m'
  friendly_id :slug_candidates, use: [:slugged, :history]
  monetize :price_sens
  acts_as_paranoid
  is_impressionable
  
  belongs_to :publisher, polymorphic: true
  has_many :stocks
  has_many :tenders, as: :tenderable
  has_one :occupancy
  has_many :comments, as: :commentable
  # has_many :tenders, through: :stocks
  has_attachments :photos, maximum: 6

  cattr_accessor :form_steps do
    %w(place characteristics situations pictures proposal)
  end

  HOUSE = ["rumah tunggal", "rumah gandeng", "town house"]
  APARTMENT = ["apartemen, rumah susun, flat"]

  attr_accessor :proposed

  serialize :details, HashSerializer
  store_accessor :details, 
                 :category, :bedrooms, :bathrooms, :level, 
                 :greenery, :garages, :property_size, :lot_size
  serialize :location, HashSerializer
  store_accessor :location, 
                 :province, :country, :complex, :schools, :transportations
  serialize :condition, HashSerializer
  store_accessor :condition,
                 :form_step, :state, :for_sale, :for_rent, 
                 :vacant, :anno, :inspected, #:proposed,
                 :mortgage_period_left, :outstanding_mortgage

  attr_wannabe_bool :for_sale, :for_rent, :vacant, :inspected

  before_create :set_default_values!
  geocoded_by :full_street_address 
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  scope :vacancy, -> { where("houses.details->>'vacant' = 'yes'") }


  def full_street_address
     [address, city, province, country].compact.join(', ')
  end

  def short_address
    "#{address} of #{city}"
  end

  def placeholder(type)
    if type == 'path'
      "http://res.cloudinary.com/instilla/image/upload/v1463307900/asset/png/house_2.png"
    else
      "asset/png/house_2"
    end
  end

  def display_picture(type)
    if photos.count != 0
      if type == 'path' then photos.first.path else photos.first.public_id end
    else
      if type == 'path' then placeholder('path') else placeholder('id') end
    end
  end

  def input_unfinished?
    if form_step != 'done' then true else false end
  end

  def redirect_when_undone(link)
    if self.input_unfinished?
      house_step_path(self, self.form_step)
    else
      link
    end
  end

  def house_owner
    publisher.name #if self.occupancy.holder.nil? 
  end

  def access_granted?(user)
    if user == self.publisher || user.admin? then true else false end
  end

  def already_proposed_by_user?(user)
    if user.tenders.offering.housing.all.map(&:tenderable_id).include? self.id
        true
      else
        false
      end
  end

  def states_of_house
    ["for sale", "vacant", "for rent"]
  end

  def slug_candidates
    [ :short_address, 
      [:short_address, :province], [:short_address, :province, :ticker]
    ]
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
    self.for_rent = 'no' if self.for_rent.nil?
    self.avatar = 'first'
  end

  def refresh_tenders
    self.tenders.map{ |tender| tender.touch }
  end

  def should_generate_new_friendly_id?
    address_changed? || city_changed? || super
  end
  # def create_relation!
  #   if self.vacant? 
  #     create_stock!
  #   else
  #     create_occupancy!
  #     create_stock! #if self.for_sale
  #   end
  # end
  # def create_stock!
  #   Stock.create(
  #     holder: self.publisher, house: self, initial: 'yes',
  #     price: self.price/1000, volume: 1000
  #   )
  # end
  # def create_occupancy!
  #   Occupancy.create(
  #     holder: self.publisher, house: self,
  #     rental: false, started_at: Date.today,
  #     annual_rental: self.price * 0.05, tradeable: true
  #   )
  # end
end