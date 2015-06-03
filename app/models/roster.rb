class Roster < ActiveRecord::Base
  belongs_to :rosterable, polymorphic: true
  belongs_to :user

  validates_associated :user
  validates_presence_of :rosterable_type, :rosterable_id, :role

  attr_accessor :user_email, :user_phone, :password, :password_confirmation,
			  :first_name, :last_name

  # before_create :check_attributes!

  scope :firm_team, -> { where(rosterable_type: 'Firm') }

  def starter?
	if self.firm.starter_email == self.user.email || self.firm.starter_phone == self.user.phone_number
		return true
	end
  end



private

  def check_attributes!
	if password && password_confirmation && first_name && last_name
	  a = User.new(
			email: user_email, phone_number: user_phone,
			password: password, password_confirmation: password_confirmation,
			first_name: first_name, last_name: last_name
			)
	  a.save!
	  self.user_id = a.id
	else
	  if user_email && user_phone
		b =  User.find_by_email_and_phone_number(user_email, user_phone)
			self.user_id = b.id
	  end
	end
  end

end
