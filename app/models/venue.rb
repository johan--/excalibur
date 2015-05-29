class Venue < ActiveRecord::Base
  belongs_to :firm
  has_many 	 :courts
  has_many 	 :followers, as: :followed

  # Pagination
  paginates_per 20

  def average_price
  	self.courts.map{ |court| court.price }.sum / self.courts.count
  end

  def all_reservations
  	self.courts.map{ |court| court.reservations }
  end
end
