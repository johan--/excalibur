class Document < ActiveRecord::Base
  include WannabeBool::Attributes
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged  

  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes, :state, 
  					:checked, :flagged
  
  attr_wannabe_bool :checked, :flagged

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
    [self.checked, self.flagged].each{ |a| a = false }
  end

end