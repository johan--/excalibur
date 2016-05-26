class User < ActiveRecord::Base
  include WannabeBool::Attributes
  include UserAdmin
  include Pacecar
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_commentable
  acts_as_paranoid

  acts_as_liker
  acts_as_likeable

  TEMP_EMAIL_PREFIX = 'change_me'
  TEMP_EMAIL_REGEX = /\Achange_me/

  serialize :preferences, HashSerializer
  store_accessor :preferences, 
          :currency, :open, :understanding, :developer, 
          :notification, :repayment_period
  serialize :profile, HashSerializer
  store_accessor :profile, 
    :phone_number, :about, :last_education, :first_name, :last_name,
    :marital_status, :work_experience, :number_dependents, :occupation,
    :monthly_income, :monthly_expense, :address, :location, 
    :auth_with, :browser_id
  
  attr_wannabe_bool :open, :understanding, :developer, :notification
  attr_accessor :image_id, :category

# Relations
  has_many :identities,  dependent: :destroy 
  has_many :documents, as: :owner
  has_many :houses, as: :publisher
  has_many :acquisitions, as: :benefactor
  has_many :posts
  has_many :comments
  has_many :comments, as: :commentable
  # has_many :assessments, -> { where(subject: 'kapiten') }, class_name: 'Comment'
  has_many :tenders, as: :starter
  has_many :bids, as: :bidder
  has_many :stocks, as: :holder
  has_many :invoices, as: :recipient
  has_many :payments, as: :sender
  # analytics
  has_many :visits

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [
    :facebook, :google_oauth2, :linkedin
  ]

  # Pagination
  paginates_per 30

  # Validations
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :name, :presence => true
  validates :auth_token, uniqueness: true

  before_create :set_auth_token!, :set_preferences!
  # before_save :up_name
    
  scope :developers, -> { 
    where("users.preferences->>'developer' = :true", true: "true") 
  }
  scope :omniauthers, -> { 
    # where.not("users.profile->>'auth_with' = :provider", provider: nil) 
    where.not('profile @> ?', {auth_with:''}.to_json)
  }  
  scope :admins, -> { where(admin: true) }    
  
  def using_omniauth?
    return true if !identities.empty?
    return false if identities.empty?
  end

  def has_proposals?
    if self.tenders.offering.count != 0
      return true
    else
      return false
    end
  end

  def has_houses?
    if self.houses.count != 0
      return true
    else
      return false
    end
  end

  def already_bid?(tender)
    if tender.bids.usermade.where(bidder_id: self.id).first then true else false end
  end  

  def has_documents?(doc)
    if self.documents.by_types(doc).count != 0
      return true
    else
      return false
    end
  end 

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0,20]
      user.password_confirmation = user.password
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.name       = auth.info.name
      user.location   = auth.info.location if auth.info.location
      user.avatar     = auth.info.image if auth.info.image
      user.auth_with  = auth.provider
      user.understanding = 'yes'
    end
  end

  def approve_of_this_user(user)
    self.like!(user)
  end
  def retract_approval_of_this_user(user)
    self.unlike!(user)
  end

# private

  # def up_name
  #   self.name = name.titleize
  # end

  def set_auth_token!
    begin
      self.auth_token = generate_auth_token!
    end while self.class.exists?(auth_token: auth_token)    
  end

  def set_preferences!
    self.currency = 'idr'
    self.open = 'yes'
    self.notification = 'yes'
    self.auth_with = '' if self.auth_with.nil?
  end

  def generate_auth_token!
    SecureRandom.uuid.gsub(/\-/,'')
  end

  def slug_candidates
    [
      :name,
      [:name, :email]
    ]
  end
end