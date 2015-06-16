class User < ActiveRecord::Base  
# Relations
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
  
  devise :omniauthable, :omniauth_providers => [:facebook]

  # Pagination
  paginates_per 100

  # Validations
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :category

  # attr_accessor :login

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

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(
        ["lower(phone_number) = :value OR lower(email) = :value", 
        { :value => login.downcase }]
      ).first
    else
      where(conditions.to_hash).first
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(full_name:auth.extra.raw_info.name,
                  category: 1,
                  provider:auth.provider,
                  uid:auth.uid,
                  email:auth.info.email,
                  password:Devise.friendly_token[0,20],
                )
      end    
    end
  end



private

  def up_full_name
    self.full_name = full_name.titleize
  end

end
