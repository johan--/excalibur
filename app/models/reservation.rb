class Reservation < ActiveRecord::Base
  belongs_to :court
  belongs_to :booker, polymorphic: true
  has_many :transitions, class_name: "ReservationTransition"

  # scope :stale, ->(duration) { where(["state='onhold' OR (state != 'done' AND updated_at < ?)", duration.ago]) }
  # scope :cancelled, -> { where(state: cancelled) }
  # scope :completed, -> { where(state: completed) }
  scope :by_date, ->(date) { where(date_reserved: date) }
  scope :by_court, ->(court_id) { where(court_id: court_id) }
  scope :upcoming, -> { where("date_reserved < ?", Date.today) }
  scope :in_seven, -> { where("date_reserved < ?", 7.days.from_now) }
  scope :in_two, -> { where("date_reserved < ?", 14.days.from_now) }

  scope :by_venue, ->(venue_id) { joins(:court).merge(Court.by_venue(venue_id)) }
  
  before_save :set_attribute!


  


private
	
	def set_attribute!
		self.finish = start + duration.to_i.hours
	end

end
