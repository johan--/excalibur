class TenderTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition #Necessary to allow using text for metadata column

  
  belongs_to :tender, inverse_of: :tender_transitions
  serialize :metadata #Necessary to allow using text for metadata column
end
