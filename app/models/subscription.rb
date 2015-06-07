class Subscription < ActiveRecord::Base
  belongs_to :firm
  has_many	 :payments

  before_save :set_deadline
  
  # after_find :check_state
  after_touch :refresh_state!

  # aktif, kadaluwarsa, diblok
  scope :active, -> { where(state: "aktif") }
  scope :expired, -> { where(state: "kadaluwarsa") }

  def commission
    if self.category == 1
      return 0.05
    end
  end

  def current_bill #not complete, miss the commission %
  	self.firm.venues.map{ |venue| (venue.all_reservations * commission).round(0) }.compact.sum
  end

  def expired?
    # self.end_date < Date.today
    self.end_date.past?
  end

  def toggle_expiration!
    update(state: "kadaluwarsa")
  end

private
  def set_deadline
  	self.end_date = self.start_date + 35.days
  end
  
  def refresh_state!
    update(start_date: Date.today)
  end

  
end
