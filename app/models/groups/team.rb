class Team < ActiveRecord::Base
  self.inheritance_column = :type  
  scope :biz, -> { where(type: 'Business') }
  scope :backer, -> { where(type: 'Firm') } 
  has_many :rosters
  has_many :users, through: :rosters, source: :rosterable, source_type: 'User'
  has_many :addresses, through: :profile
  has_one  :profile, as: :profileable
  validates :name, :presence => true
  validates :type, :presence => true
  validates :starter_email, :presence => true
  # has_settings do |s|
  #   s.key :down_payment, defaults: { state: "on", percentage: 0.5, 
  #   								 deadline: "off" }
  #   s.key :auto_confirmation, defaults: { state: "off" }
  #   s.key :auto_promo, defaults: { state: "off" }
  # end

  after_create :starting_up

  def self.types
    %w(Business Firm)
  end

  def starter
    starter = User.find_by(email: starter_email)
  end

  def has_as_member?(user)
    if self.rosters.find_by(rosterable_id: user.id)
      return true
    else 
      return false
    end
  end

  def find_profile
    Profile.find_by(profileable_type: self.class.name, profileable_id: id)
  end

private
  def starting_up
    starter
    roster = self.rosters.build(rosterable: starter, 
                                role: 0, state: "aktif")
    # subs = self.build_subscription(category: 1, start_date: Date.today, state: "aktif")
    roster.save!
    # subs.save!
  end

end