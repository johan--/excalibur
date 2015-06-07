class Firm < ActiveRecord::Base
  has_many :venues
  has_one  :subscription
  has_many :payments, through: :subscription
  has_many :rosters, as: :rosterable
  has_many :users, through: :rosters,
					 source: :rosterable, source_type: 'Firm'

  # accepts_nested_attributes_for :subscription

  has_settings do |s|
    s.key :down_payment, defaults: { state: "on", percentage: 0.5, 
    								 deadline: "off" }
    s.key :auto_confirmation, defaults: { state: "off" }
    s.key :auto_promo, defaults: { state: "off" }
  end

  def starter
    self.users.first
  end

  # def all_reservations
  #   Reservation.in_state(:confirmed, :completed).between_date(start_date, end_date).by_venue(ven) 
  #   result = arr.map{ |res| (res.charge * self.commission).round(0) }.compact.sum
  # end

  # def switch_preferences!(name, key, value)
  # 	self.settings(name.to_sym).update_attributes!(
  # 		Hash.try_convert({key=>value}))
  # end

end
