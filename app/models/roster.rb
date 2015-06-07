class Roster < ActiveRecord::Base
  belongs_to :rosterable, polymorphic: true
  belongs_to :user

  validates_associated :user
  validates_presence_of :rosterable_type, :rosterable_id, :role

  attr_accessor :user_email, :user_phone, :password, 
                :password_confirmation, :full_name

  before_create :check_attributes!
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :firm_team, -> { where(rosterable_type: 'Firm') }
  scope :active, -> { where(state: 'aktif') }

  def starter?
  	if self.firm.starter_email == self.user.email || self.firm.starter_phone == self.user.phone_number
  		return true
  	end
  end

  def board?
  	return true if role == 0
  end

  def manager?
  	return true if role == 1
  end

  def staff?
  	return true if role == 2
  end

  def not_active_member
  end

private

  def check_attributes!
  	if password && password_confirmation && full_name
  	  a = User.new(
  			email: user_email, phone_number: user_phone,
  			password: password, password_confirmation: password_confirmation,
  			full_name: full_name, category: 2
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
