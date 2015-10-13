class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  # customize here

end
Ahoy.cookie_domain = :all  
Ahoy.visit_duration = 4.hours
Ahoy.geocode = false