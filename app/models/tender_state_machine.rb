class TenderStateMachine
  include Statesman::Machine

  state :open, initial: true
  state :closed
  state :running
  state :success
  state :failed

  transition from: :open, to: [:running, :closed, :failed]
  transition from: :closed, to: [:open, :running, :failed]
  transition from: :running, to: [:success, :failed]
  # transition from: :failed

  # guard_transition(to: :closed) do |tender|
  #   tender.fulfilled?
  # end

  # guard_transition(to: :open) do |tender|
  #   !tender.fulfilled?
  # end

  # guard_transition(to: :running) do |tender|
  #   tender.bids.each{ |b| b. }
  # end

  after_transition do |tender, transition|
    tender.state = transition.to_state
    tender.save!
  end

  after_transition(to: :running) do |tender, transition|
    #make invoice for all bids
    tender.bids.each{ |b| b.request_funding }
  end

  after_transition(to: :success) do |tender, transition|
    #make stock untradeable and expired
    tender.expire_stock! if tender.tenderable.should_be_expired?
  end
  # before_transition(from: :checking_out, to: :cancelled) do |order, transition|
  #   order.reallocate_stock
  # end

  # before_transition(to: :purchased) do |order, transition|
  #   PaymentService.new(order).submit
  # end

  # after_transition(to: :success) do |tender, transition|
  #   if tender.aqad?('murabaha')
  #   Tender.create(te)
  #     model.state = transition.to_state
  #     model.save!
  #   end
  # end
end