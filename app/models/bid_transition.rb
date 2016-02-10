class BidTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :bid, inverse_of: :bid_transitions
  serialize :metadata #Necessary to allow using text for metadata column
end
