class User < ActiveRecord::Base  
  include WannabeBool::Attributes
  include UserChecking
  include UserAdmin
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  TEMP_EMAIL_PREFIX = 'change_me'
  TEMP_EMAIL_REGEX = /\Achange_me/

  serialize :preferences, HashSerializer
  store_accessor :preferences, 
          :language, :currency, :open, :client, :financier, :understanding
  serialize :profile, HashSerializer
  store_accessor :profile, 
    :phone_number, :about, :last_education, :credibility,
    :marital_status, :work_experience, :number_dependents, :occupation,
    :monthly_income, :monthly_expense, :address, :facebook, :google, :twitter
  
  attr_wannabe_bool :financier, :client, :open
  attr_accessor :image_id

# Relations
  has_one  :identity
  has_many :documents, as: :owner
  has_many :posts
  has_many :comments
  has_many :rosters, as: :rosterable
  has_many :teams, through: :rosters #Dont have to use source & source type
  has_many :businesses, through: :teams, 
                        source: :teamable, source_type: "Business"
  has_many :tenders, as: :tenderable
  has_many :bids, as: :bidder
  # analytics
  has_many :visits

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Pagination
  paginates_per 100

  # Validations
  validates :email, :presence => true
  validates :name, :presence => true
  validates :auth_token, uniqueness: true

  before_create :set_auth_token!, :set_default_values!
  before_save :up_name
    
  scope :financiers, -> { 
    where("users.preferences->>'financier' = :true", true: "true") 
  }
  scope :clients, -> { 
    where("users.preferences->>'client' = :true", true: "true") 
  }    

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup

      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email #if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          # name: auth.extra.raw_info.name,
          name: auth.info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20], 
          avatar: auth.info.image
          # client: true
        )
        user.save!
      end
    end
    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
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
    self.language = 'bahasa'
    self.currency = 'idr'
    self.credibility = 'C'
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