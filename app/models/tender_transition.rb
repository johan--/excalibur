class TenderTransition < ActiveRecord::Base
  # include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :tender, inverse_of: :tender_transitions
end
