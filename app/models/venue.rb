class Venue < ActiveRecord::Base
  belongs_to :firm
  has_many 	 :courts
  has_many 	 :followers, as: :followed
  
  accepts_nested_attributes_for :courts, :reject_if => :all_blank
  
  scope :by_firm, ->(firm_id) { where(firm_id: firm_id) }

  # has_settings do |s|
  #   s.key :primeday, defaults: { state: "on", 
  #                                active: "weekends", increase: "20000" }                
  #   s.key :primetime, defaults: { state: "on", start_at: "14:00", 
  #                    end_at: "24:00", increase: "20000" }
  # end

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
