class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  # user id is automatically put into visit when the visitors logged in
  # current user is equal to user method in ahoy

  # customize here
  
  # def track_visit(options)
    # super do |visit|
    #   visit.referring_domain = visit_properties.landing_params["gclid"]
    #   visit.referral_code = 0
    # end
  # end

  def track_event(name, properties, options)
    super do |event|
      event.ip = request.ip
      if user.present?
      	event.user_id = user.id
      end
    end
  end



end
Ahoy.cookie_domain = :all  
Ahoy.visit_duration = 4.hours
Ahoy.geocode = false