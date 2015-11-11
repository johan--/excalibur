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

    scope :blog, -> { 
      where("ahoy_events.properties->>'category' = :category", category: "Blog") 
    }
    scope :user, -> { 
      where("ahoy_events.properties->>'category' = :category", category: "User") 
    }
    scope :document, -> { 
      where("ahoy_events.properties->>'category' = :category", category: "Document") 
    }
    scope :proposal, -> { 
      where("ahoy_events.properties->>'category' = :category", category: "Tender") 
    }    
    scope :simulation, -> { 
      where("ahoy_events.properties->>'category' = :category", category: "Simulation") 
    }        
    # scope(:not), ->(scope) { where(scope.where_values.reduce(:and).not) }
  end
end
