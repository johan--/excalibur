class DocumentTransition < ActiveRecord::Base
  # Not needed, already using json column
  # include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :document, inverse_of: :document_transitions

end
