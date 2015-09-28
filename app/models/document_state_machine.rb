class DocumentStateMachine
  include Statesman::Machine

  state :uploaded, initial: true
  state :verified
  state :flagged
  state :dropped

  transition from: :uploaded, to: [:verified, :flagged]
  transition from: :verified, to: [:flagged, :uploaded, :dropped]
  transition from: :flagged,  to: [:verified, :dropped, :uploaded]
  # transition from: :dropped

  guard_transition(from: :uploaded, to: :verified) do |document|
    document.checked?
  end

  guard_transition(to: :flagged) do |document|
    document.flagged?
  end

  guard_transition(to: :dropped) do |document|
    document.flagged? && document.checked?
  end

  guard_transition(to: :uploaded) do |document|
    !document.flagged? && !document.checked?
  end

  after_transition do |document, transition|
    document.state = transition.to_state
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