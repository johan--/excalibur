class DocumentStateMachine
  include Statesman::Machine

  state :uploaded, initial: true
  state :verified
  state :flagged
  state :dropped

  transition from: :uploaded, to: [:verified, :flagged]
  transition from: :verified, to: [:flagged]
  transition from: :flagged,  to: [:verified, :dropped]
  # transition from: :dropped

  guard_transition(from: :uploaded, to: :verified) do |document|
    document.checked?
  end

  guard_transition(from: :uploaded, to: :flagged) do |document|
    document.flagged?
  end

  guard_transition(from: :flagged, to: :dropped) do |document|
    document.flagged? && document.checked?
  end

  guard_transition(from: :flagged, to: :verified) do |document|
    document.checked?
  end

  after_transition do |document, transition|
    document.status_quo = transition.to_state
    document.save!
  end

  # before_transition(from: :checking_out, to: :cancelled) do |order, transition|
  #   order.reallocate_stock
  # end

  # before_transition(to: :purchased) do |order, transition|
  #   PaymentService.new(order).submit
  # end

  # after_transition(to: :purchased) do |order, transition|
  #   MailerService.order_confirmation(order).deliver
      # model.state = transition.to_state
      # model.save!
  # end
end