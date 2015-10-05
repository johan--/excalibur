class Document < ActiveRecord::Base
  include WannabeBool::Attributes
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged  

  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes, :state, :doc_type,
  					:checked, :flagged
  
  attr_wannabe_bool :checked, :flagged

  # Pagination
  paginates_per 30

  def self.categories
    %w(identitas penghasilan pengeluaran kepemilikan lain-lain)
  end

# Statesman stuffs
  has_many :document_transitions
  # Initialize the state machine
  def state_machine
    @state_machine ||= DocumentStateMachine.new(
    	self, transition_class: DocumentTransition)
  end
  # Optionally delegate some methods
  delegate :can_transition_to?, :transition_to!, :transition_to, 
  		   :current_state, to: :state_machine
###############################
  before_create :set_default

  scope :verifieds, -> { 
    where("documents.details->>'state' = :state", state: "verified") 
  }    
  scope :by_types, ->(doc_type) { 
    where("documents.details->>'doc_type' = :type", type: doc_type) 
  }
  scope :identities, -> { 
    where("documents.details->>'doc_type' = :type", type: "identitas") 
  }
  scope :incomes, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti penghasilan") 
  }
  scope :expenses, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti pengeluaran") 
  }
  scope :collaterals, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti kepemilikan") 
  }
  def transitioning!
    if self.checked? &&  self.flagged?
      self.state_machine.transition_to!(:dropped)
    else
      if self.checked?
        self.state_machine.transition_to!(:verified)
      elsif self.flagged?
        self.state_machine.transition_to!(:flagged)
      elsif !self.checked? &&  !self.flagged?
        self.state_machine.transition_to!(:uploaded)
      end
    end
  end

private
  def slug_candidates
    [ 
      :name,
      [:name, :owner_id]
    ]
  end

  def self.transition_class
    DocumentTransition
  end

  def self.initial_state
    DocumentStateMachine.initial_state
  end

  def set_default
    self.checked = false
    self.flagged = false
    self.state = DocumentStateMachine.initial_state
    self.name = "#{self.doc_type} #{self.owner.name}"
  end

end