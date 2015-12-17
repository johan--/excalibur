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
  attr_accessor :image_id, :category

# Relations
  has_one  :identity
  has_many :documents, as: :owner
  has_many :posts
  has_many :comments
  has_many :rosters, as: :rosterable
  has_many :term_sheets, as: :recipient

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
  paginates_per 30

  # Validations
  validates :email, :presence => true
  validates :name, :presence => true
  validates :auth_token, uniqueness: true

  before_create :set_auth_token!, :set_default_values!, 
                :determine_category!
  before_save :up_name
    
  scope :financiers, -> { 
    where("users.preferences->>'financier' = :true", true: "true") 
  }
  scope :clients, -> { 
    where("users.preferences->>'client' = :true", true: "true") 
  }    
  
  def has_been_offered_term_sheet?(deal)
    if term_sheets_offered(deal) == 0
      return false
    else
      return true
    end
  end

  def term_sheets_offered(deal)
    TermSheet.where(recipient: self, deal: deal).count
  end

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
    self.language = 'bahasa'
    self.currency = 'idr'
    self.credibility = 'C'
  end

  def determine_category!
    unless self.category.nil?
      if self.category == 'client'
        self.client = "true"
        self.financier = "false"
      elsif self.category == 'financier'
        self.client = "false"
        self.financier = "true"      
      end
    end
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