class TenderStateMachine
  include Statesman::Machine

  state :fresh, initial: true
  state :processing
  state :qualified
  state :success
  state :denied
  state :dropped

  transition from: :fresh, to: [:processing, :dropped, :qualified]
  transition from: :processing, to: [:qualified]
  transition from: :qualified,  to: [:processing, :success, :denied]
  transition from: :denied,  to: [:processing, :dropped]
  # transition from: :dropped

  guard_transition(to: :qualified) do |tender|
    tender.fulfilled?
  end

  guard_transition(from: :qualified, to: :success) do |tender|
    # 
  end

  guard_transition(from: :qualified, to: :denied) do |tender|
    # 
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