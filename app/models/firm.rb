class Firm < ActiveRecord::Base
  has_one  :subscription
  has_many :payments, through: :subscription
  has_many :rosters, as: :rosterable
  has_many :users, through: :rosters,
					 source: :rosterable, source_type: 'Firm'

  # accepts_nested_attributes_for :venues

  has_settings do |s|
    s.key :down_payment, defaults: { state: "on", percentage: 0.5, 
    								 deadline: "off" }
    s.key :auto_confirmation, defaults: { state: "off" }
    s.key :auto_promo, defaults: { state: "off" }
  end

  # after_create :starting_up

  def starter
    self.users.first
  end

  def starting_up(current_user)
    roster = self.rosters.build(user: current_user, role: 0, state: "aktif")
    subs = self.build_subscription(category: 1, start_date: Date.today, state: "aktif")
    roster.save!
    subs.save!
  end


end
