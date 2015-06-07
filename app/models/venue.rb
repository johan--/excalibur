class Venue < ActiveRecord::Base
  belongs_to :firm
  has_many 	 :courts
  has_many 	 :followers, as: :followed

  scope :by_firm, ->(firm_id) { where(firm_id: firm_id) }

  # Pagination
  paginates_per 20

  def average_price
  	self.courts.map{ |court| court.price }.sum / self.courts.count
  end

  def all_reservations
    start = self.firm.subscription.start_date
    finish = self.firm.subscription.end_date
  	# arr_1 = Reservation.in_state(:confirmed, :completed)
    arr_1 = Reservation.in_state(:confirmed, :completed)
    arr_2 = arr_1.between_date(start, finish).by_venue(self.id) 
    return arr_2.map{ |res| res.charge }.compact.sum    
  end


end
