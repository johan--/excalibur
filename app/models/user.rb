class User < ActiveRecord::Base  
  include UserRelationship
  include UserChecking
  include UserAdmin
  TEMP_EMAIL_PREFIX = 'change_me'
  TEMP_EMAIL_REGEX = /\Achange_me/
# Relations
  has_one  :identity
  has_many :posts
  has_many :rosters, as: :rosterable
  has_many :teams, through: :rosters #Dont have to use source & source type
  has_one :profile, as: :profileable
  has_many :tenders
  has_many :bids, as: :bidder
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable#, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Pagination
  paginates_per 100

  # Validations
  # validates_presence_of :category, :email, :password, :password_confirmation
  validates :email, :presence => true
  validates :full_name, :presence => true
  validates :auth_token, uniqueness: true

  before_create :set_auth_token!
  before_save :up_full_name

  scope :players, -> { where(category: 1) }
  scope :operators, -> { where(category: 2) }

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
          # full_name: auth.extra.raw_info.name,
          full_name: auth.info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
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

  def up_full_name
    self.full_name = full_name.titleize
  end

  def set_auth_token!
    begin
      self.auth_token = generate_auth_token!
    end while self.class.exists?(auth_token: auth_token)    
  end

  def generate_auth_token!
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
