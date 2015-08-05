class Contact < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true,
  			 		format: { with: EMAIL_REGEX, on: :create }
  validates :name, presence: true
  validates :message, length: { minimum: 10 },
  					  presence: true
end
