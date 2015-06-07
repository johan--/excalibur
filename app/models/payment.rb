class Payment < ActiveRecord::Base
  belongs_to :subscription
  validates_associated :subscription

  validates_presence_of :pay_code, :total, :pay_day

  after_create :impact_subscription!


private

  def impact_subscription!
  	self.subscription.touch
  	# subscription = self.subscription
  	# subscription.start_date = Date.today
  	# subscription.end_date = 35.days.from_now.to_date
  	# subscription.save!
  end

end