class Reservation < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries
  has_many :reservation_transitions
  
  belongs_to :court
  belongs_to :booker, polymorphic: true

  # scope :cancelled, -> { where(state: cancelled) }
  # scope :completed, -> { where(state: completed) }

  # Reservation.in_state(:state_1, :state_2, etc)
  default_scope { order(date_reserved: :desc) }
  # default_scope where(:rating => 'G')
  scope :by_time, ->(start, finish) { where(start: start, finish: finish) }
  scope :by_date, ->(date) { where(date_reserved: date) }
  scope :by_court, ->(court_id) { where(court_id: court_id) }
  scope :upcoming, -> { where("date_reserved > ?", Date.today) }
  scope :in_seven, -> { where("date_reserved < ?", 7.days.from_now) }
  scope :in_fourteen, -> { where("date_reserved < ?", 14.days.from_now) }

  scope :by_venue, ->(venue_id) { joins(:court).merge(Court.by_venue(venue_id)) }
  
  before_save :set_attribute!

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  def code
    date = date_reserved.strftime("%d/%m/%Y")
    "#{court.venue.name}: #{court.name} #{date}-#{start}"
  end           

  def state_machine
    @state_machine ||= ReservationStateMachine.new(self, 
                      transition_class: ReservationTransition)
  end

  def first_in_line?
    arr = queueing_up(self)
    return true if arr.first.id == self.id
  end

  def queueing_up(r)
    Reservation.by_court(r.court_id).by_date(r.date_reserved).by_time(r.start, r.finish).order(created_at: :asc)
  end

  def confirmed?
    return true if self.state_machine.current_state == 'confirmed'
  end

  def completed?
    return true if self.state_machine.current_state == 'completed'
  end

  def waiting?
    return true if self.state_machine.current_state == 'waiting'
  end

  def pending?
    return true if self.state_machine.current_state == 'pending'
  end

  def cancelled?
    return true if self.state_machine.current_state == 'cancelled'
  end

  def down_payment
    (self.charge * 0.5).round(0)
  end

private
	
  def self.transition_class
    ReservationTransition
  end

  def self.initial_state
    :pending
  end

	def set_attribute!
		self.finish = start + duration.to_i.hours
    self.charge = self.court.price * self.duration
	end


end
