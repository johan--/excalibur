class Court < ActiveRecord::Base
  belongs_to :venue
  has_many 	 :reservations
end
