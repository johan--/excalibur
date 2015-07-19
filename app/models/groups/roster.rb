class Roster < ActiveRecord::Base
  belongs_to :rosterable, polymorphic: true
  belongs_to :team

  validates_associated :team
  validates_presence_of :rosterable_type, :rosterable_id, :role

  attr_accessor :user_email, :user_name, :password, 
                :password_confirmation, :full_name

  before_create :check_attributes!
  scope :by_id, ->(id) { where(rosterable_id: id) }
  scope :users, -> { where(rosterable_type: 'User') }
  scope :active, -> { where(state: 'aktif') }

  def starter?
  	if self.team.starter_email == self.user.email || self.team.starter_phone == self.user.phone_number
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
  	  new_user = User.new(
  			email: user_email, #phone_number: user_phone,
  			password: password, password_confirmation: password_confirmation,
  			full_name: full_name, category: 2
  			)
  	  new_user.save!
  	  self.rosterable = new_user
  	else
  	  if user_email && full_name
  		user =  User.find_by(email: user_email, full_name: full_name)
  			self.rosterable = user
  	  end
  	end
  end

end
