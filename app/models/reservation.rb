class Reservation < ActiveRecord::Base
  belongs_to :court
  belongs_to :booker, polymorphic: true
  
  # scope :stale, ->(duration) { where(["state='onhold' OR (state != 'done' AND updated_at < ?)", duration.ago]) }
  # scope :cancelled, -> { where(state: cancelled) }
  # scope :completed, -> { where(state: completed) }
  scope :upcoming, -> { where("date_reserved < ?", Date.today) }
  scope :in_seven, -> { where("date_reserved < ?", 7.days.from_now) }
  scope :in_two, -> { where("date_reserved < ?", 14.days.from_now) }

  before_save :set_attribute!



private
	
	def set_attribute!
		self.finish = start + duration.to_i.hours
	end

end
