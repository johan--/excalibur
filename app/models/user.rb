class User < ActiveRecord::Base  
  TEMP_EMAIL_PREFIX = 'change_me'
  TEMP_EMAIL_REGEX = /\Achange_me/
# Relations
  has_one :identity
  has_many :posts
  has_many :rosters
  has_many :relationships,  foreign_key: "follower_id", 
                            dependent: :destroy

  has_many :friends, through: :relationships, 
                            source: :followed, source_type: 'User'
  has_many :venues, through: :relationships, 
                            source: :followed, source_type: 'Venue'
                            
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers,  through: :reverse_relationships,
                        source: :follower

  has_many :reservations, as: :booker
  has_many :installments

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


  def operator?
    return true if self.category == 2
  end

  def with_no_firm?
    return true if find_firm.active.first.nil?
  end

  def find_firm
    self.rosters.firm_team
  end

  def firm_locator
    find_firm.first.rosterable
  end

  def current_reservations
    self.reservations.upcoming
  end

  # relationship methods
    def following?(followed)
      return true if following(followed)
    end

    def following(followed)
      self.relationships.find_by(
        followed_id: followed.id, followed_type: followed.class.name)
    end

    def follow!(followed)
      self.relationships.create!(
        followed_id: followed.id, followed_type: followed.class.name)
    end

    def unfollow!(followed)
      following(followed).destroy
    end  

    def favorite_venues
      self.relationships.venues.map{ |rel| rel.followed }.to_a
    end

  # admin methods
    def self.paged(page_number)
      order(admin: :desc, email: :asc).page page_number
    end

    def self.search_and_order(search, page_number)
      if search
        where("email LIKE ?", "%#{search.downcase}%").order(
        admin: :desc, email: :asc
        ).page page_number
      else
        order(admin: :desc, email: :asc).page page_number
      end
    end

    def self.last_signups(count)
      order(created_at: :desc).limit(count).select("id","email","created_at")
    end

    def self.last_signins(count)
      order(last_sign_in_at:
      :desc).limit(count).select("id","email","last_sign_in_at")
    end

    def self.users_count
      where("admin = ? AND locked = ?",false,false).count
    end


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

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
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
    # SecureRandom.base64.tr('+/=', 'Qrt')
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
