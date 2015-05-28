class ReservationTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :reservation, inverse_of: :reservation_transitions
end
