class Document < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes, :status_quo, 
  					:checked, :flagged

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

  def checked?
  	if self.checked == true
  		return true
  	else
  		return false
  	end
  end

  def flagged?
  	if self.flagged == true
  		return true
  	else
  		return false
  	end
  end

  def verifying
  	self.checked = true
  	self.flagged = false
  	self.transition_to!(:verified)
  end

  def flagging
  	self.flagged = true
  	self.checked = false
  	self.transition_to!(:flagged)
  end

  def dropping
  	self.flagged = true
  	self.checked = true
  	self.transition_to!(:dropped)
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
    :uploaded
  end

end