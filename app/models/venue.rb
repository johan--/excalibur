class Venue < ActiveRecord::Base
  belongs_to :firm
  has_many 	 :courts
  has_many 	 :followers, as: :followed

  # Pagination
  paginates_per 20

  # def all_reservations
  # 	self.courts.reservations
  # end
end
