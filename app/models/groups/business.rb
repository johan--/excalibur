class Business < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_one  :team, as: :teamable
  has_many :rosters, through: :team
  has_many :users, through: :rosters, source: :rosterable, source_type: 'User'
  has_many :tenders, as: :tenderable

  serialize :profile, HashSerializer
  store_accessor :profile, 
  		:open, :about, :anno, :founding_size, 
      :city, :province, :addresses,
    	:online_presence_types, :offline_presence_types
  
  # paginates_per 5

  attr_accessor :starter_email

  before_create :set_default_values!
  after_create :set_team_up

  scope :established_at, ->(year) { 
    where("businesses.profile->>'anno' = :year", year: "#{year}") 
  }

private
  def set_default_values!
    self.open = true
    self.online_presence_types = []
    self.offline_presence_types = []
  end

  def set_team_up
  	self.create_team(
  		category: "Bisnis", name: "Tim #{self.name}", 
  		starter_email: starter_email)
  end

  def slug_candidates
    [
      :name,
      [:name, :anno],
      [:name, :anno, :city]
    ]
  end
end