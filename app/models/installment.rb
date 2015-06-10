class Installment < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :user
  validates_presence_of :pay_code, :total, :pay_day


  after_create :move_into_waiting!
  

private

  def move_into_waiting!
  	self.reservation.transition_to!(:waiting)
  end

end
