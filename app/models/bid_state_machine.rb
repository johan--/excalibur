class BidStateMachine
  include Statesman::Machine

  state :pending, initial: true
  # state :confirmed
  state :success
  state :failed
  state :waiting

  transition from: :pending, to: [:success, :failed, :waiting]
  transition from: :success, to: :failed
  transition from: :waiting, to: [:pending, :success]
  # transition from: :confirmed, to: [:success, :failed]
  # transition from: :failed

  # guard_transition(to: :confirmed) do |tender|
  #   bid.paid?
  # end

  after_transition do |bid, transition|
    bid.state = transition.to_state
    bid.save!
  end

  after_transition(to: :success) do |bid, transition|
    bid.transfer_ownership!
    bid.process_occupancy! if bid.client?
  end

  # before_transition(from: :checking_out, to: :cancelled) do |order, transition|
  #   order.reallocate_stock
  # end

  # before_transition(to: :purchased) do |order, transition|
  #   PaymentService.new(order).submit
  # end
end