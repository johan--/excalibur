# class Invoice < ActiveRecord::Base
#   belongs_to :invoiceable, polymorphic: true
#   belongs_to :recipient, polymorphic: true
#   has_many 	 :payments

#   monetize :amount_sens
#   acts_as_paranoid
#   protokoll :ticker, :pattern => "BIL%y####"

#   serialize :details, HashSerializer


#   before_create :set_defaults
#   after_touch	:check_billing

# 	# scope :paid, -> { where(admin: true) }

#   def total_paid
#   	self.payments.verified.map{ |p| p.amount }.compact.sum
#   end

#   def paid?
#   	return true if total_paid == self.amount
#   end

# private
#   def check_billing
#   	if deadline.past?
#   		update(state: 'warning')
#   	else
# 	  	if paid?
# 	  	  update(state: 'complete')
# 	  	else
# 	  	  update(state: 'active')
# 	  	end
# 	  end
# 	  self.invoiceable.touch
#   end

#   def set_defaults
#   	self.state = 'active'
#   	self.amount = self.invoiceable.worth if self.amount.nil?
#   end
end