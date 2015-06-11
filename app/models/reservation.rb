class Reservation < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries
  has_many :reservation_transitions
  has_many :installments

  belongs_to :court
  belongs_to :booker, polymorphic: true

  # scope :cancelled, -> { where(state: cancelled) }
  # scope :completed, -> { where(state: completed) }

  default_scope { order(date_reserved: :asc) }
  
  scope :paid, -> { where(state: ['confirmed', 'completed', 'cancelled']) }
  scope :unpaid, -> { where(state: ['pending']) }
  scope :confirmed, -> { where(state: ['confirmed']) }
  scope :waiting, -> { where(state: ['waiting']) }
  scope :pending, -> { where(state: ['pending']) }
  scope :by_time, ->(start, finish) { where(start: start, finish: finish) }
  scope :by_date, ->(date) { where(date_reserved: date) }
  # scope :between_date, ->(date_1, date_2) { where("date_reserved between ? and ?", date_1, date_2) } 
  scope :between_date, ->(date_1, date_2) { where(date_reserved: date_1..date_2) } 
  scope :by_court, ->(court_id) { where(court_id: court_id) }
  scope :upcoming, -> { where("date_reserved > ?", Date.today) }
  scope :in_seven, -> { where("date_reserved < ?", 7.days.from_now) }
  scope :in_fourteen, -> { where("date_reserved < ?", 14.days.from_now) }

  scope :by_venue, ->(venue_id) { joins(:court).merge(Court.by_venue(venue_id)) }
  scope :upcoming_with_states, ->(venue) { by_venue(venue).upcoming.group_by{ |r| r.date_reserved } }

  before_create :set_state!
  before_save :set_attribute!

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  # def chargeable
  #  Reservation.in_state(:confirmed, :completed)
  # end

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

  def has_installments?
    return true if self.installments.count != 0
  end

  def queueing_up(r)
    Reservation.by_court(r.court_id).by_date(r.date_reserved).by_time(r.start, r.finish).order(created_at: :asc)
  end

  def confirmed?
    return true if self.state == 'confirmed'
  end

  def completed?
    return true if self.state == 'completed'
  end

  def waiting?
    return true if self.state == 'waiting'
  end

  def pending?
    return true if self.state == 'pending'
  end

  def cancelled?
    return true if self.state == 'cancelled'
  end

  def down_payment
    (self.charge * 0.5).round(0)
  end

  def upcoming_reservations(state, venue)
    self.in_state(state.to_sym).by_venue(venue).upcoming.group_by{ |r| r.date_reserved}
  end

private
	
  def self.transition_class
    ReservationTransition
  end

  def self.initial_state
    :pending
  end

  def set_state!
    self.state = "pending"
  end

	def set_attribute!
		self.finish = start + duration.to_i.hours
    self.charge = self.court.price * self.duration
	end


end
