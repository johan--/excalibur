class ReservationStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :confirmed
  state :completed
  state :cancelled
  state :waiting
  # state :refunded

  transition from: :pending,    to: [:confirmed, :waiting, :cancelled]
  transition from: :confirmed,  to: [:completed, :cancelled]
  transition from: :waiting,    to: [:confirmed, :cancelled]
  # transition from: :shipped,    to: :refunded

  # guard_transition(to: :checking_out) do |order|
  #   order.products_in_stock?
  # end

  # before_transition(from: :checking_out, to: :cancelled) do |order, transition|
  #   order.reallocate_stock
  # end

  # before_transition(to: :purchased) do |order, transition|
  #   PaymentService.new(order).submit
  # end

  # after_transition(to: :purchased) do |order, transition|
  #   MailerService.order_confirmation(order).deliver
  # end
end