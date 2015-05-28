class Court < ActiveRecord::Base
  belongs_to :venue
  has_many 	 :reservations

  scope :by_venue, ->(venue_id) { where(venue_id: venue_id) }
end
