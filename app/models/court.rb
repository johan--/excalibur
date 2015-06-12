class Court < ActiveRecord::Base
  belongs_to :venue
  has_many 	 :reservations

  scope :by_venue, ->(venue_id) { where(venue_id: venue_id) }

  has_settings do |s|
    s.key :primeday, defaults: { state: "on", 
                                 active: "weekends", increase: "20000" }                
    s.key :primetime, defaults: { state: "on", start_at: "14:00", 
                     end_at: "24:00", increase: "20000" }
  end

    
end
