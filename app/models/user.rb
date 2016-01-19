class User < ActiveRecord::Base
  include RailsSettings::Extend  
  include WannabeBool::Attributes
  include UserChecking
  include UserAdmin
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_commentable
  acts_as_paranoid

  TEMP_EMAIL_PREFIX = 'change_me'
  TEMP_EMAIL_REGEX = /\Achange_me/

  serialize :preferences, HashSerializer
  store_accessor :preferences, 
          :currency, :open, :understanding, :developer, 
          :notification, :repayment_period
  serialize :profile, HashSerializer
  store_accessor :profile, 
    :phone_number, :about, :last_education, 
    :marital_status, :work_experience, :number_dependents, :occupation,
    :monthly_income, :monthly_expense, :address, :facebook, :google, :twitter
  
  attr_wannabe_bool :open, :understanding, :developer
  attr_accessor :image_id, :category

# Relations
  has_one  :identity
  has_many :documents, as: :owner
  has_many :houses, as: :publisher
  has_many :posts
  has_many :comments
  groupify :group_member
  groupify :named_group_member
  has_many :tenders, as: :tenderable
  has_many :bids, as: :bidder
  # analytics
  has_many :visits

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  # devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Pagination
  paginates_per 30

  # Validations
  validates :email, :presence => true
  validates :name, :presence => true
  validates :auth_token, uniqueness: true

  before_create :set_auth_token!, :set_default_values!
  before_save :up_name
    
  scope :developers, -> { 
    where("users.preferences->>'developer' = :true", true: "true") 
  }
  scope :admins, -> { where(admin: true) }    
  

  def has_documents?(doc)
    if self.documents.by_types(doc).count != 0
      return true
    else
      return false
    end
  end 

# private

  def up_name
    self.name = name.titleize
  end

  def set_auth_token!
    begin
      self.auth_token = generate_auth_token!
    end while self.class.exists?(auth_token: auth_token)    
  end

  def set_default_values!
    self.open = true
    self.currency = 'idr'
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