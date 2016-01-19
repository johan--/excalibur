class TenderStateMachine
  include Statesman::Machine

  state :open, initial: true
  state :closed
  state :success
  state :failed

  transition from: :open, to: [:closed, :failed]
  transition from: :closed, to: [:open, :success, :failed]
  # transition from: :failed

  guard_transition(to: :closed) do |tender|
    tender.fulfilled?
  end

  guard_transition(to: :open) do |tender|
    !tender.fulfilled?
  end

  after_transition do |tender, transition|
    tender.state = transition.to_state
    tender.save!
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