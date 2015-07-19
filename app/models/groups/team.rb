class Team < ActiveRecord::Base
  self.inheritance_column = :type
  scope :biz, -> { where(type: 'Business') }
  scope :backer, -> { where(type: 'Firm') } 
  has_many :rosters
  has_many :users, through: :rosters


  # has_settings do |s|
  #   s.key :down_payment, defaults: { state: "on", percentage: 0.5, 
  #   								 deadline: "off" }
  #   s.key :auto_confirmation, defaults: { state: "off" }
  #   s.key :auto_promo, defaults: { state: "off" }
  # end

  after_create :starting_up

  def starter
    self.rosters.users.first
  end

  def in_group?(user)
    return true if self.rosters.users.by_id(user.id)
  end



private
  def starting_up
    user = User.find_by(email: starter_email)
    roster = self.rosters.build(rosterable: user, 
                                role: 0, state: "aktif")
    # subs = self.build_subscription(category: 1, start_date: Date.today, state: "aktif")
    roster.save!
    # subs.save!
  end

end