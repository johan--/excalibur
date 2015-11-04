module Ahoy
  class Event < ActiveRecord::Base
    self.table_name = "ahoy_events"
    belongs_to :visit
    belongs_to :user

  	# USER = ["Uploaded avatar", "Edited user profile", 
  	# 	"Viewed user profile", "Removed avatar"]
  	# PROPOSAL = ["Viewed proposal", "Created murabahah proposal",
  	# 	"Created musyarakah proposal", "Edited murabahah proposal",
  	# 	"Edited musyarakah proposal"]

    store_accessor :properties, :title, :category, :ip, :important

   #  scope :financiers, -> { 
   #    where("users.preferences->>'financier' = :true", true: "true") 
   #  }    
  end
end
