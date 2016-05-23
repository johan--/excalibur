class SessionsController < Devise::SessionsController
  include Analyticable
  before_filter :resource_params
  skip_before_filter :authenticate_user!
  after_filter  :after_login, :only => :create

  def new
    set_as_static
    super  	
  end




private

  def resource_params
    devise_parameter_sanitizer.for(:sign_in) {|user| user.permit(
      	:email,:password, :remember_me#, :login, # :phone_number, 
      )
    }
  end

  def after_login
    if user_signed_in?
      meta_events_tracker.event!(:user, :logged_in, { auth: 'Kapiten', user_agent: request.user_agent })
      # mixpanel_tracker.alias(current_user.id, current_browser_id)
    end
  end


  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    # basic_root = 
    if request.referer == sign_in_url
      if resource.admin? then admin_root_path else super end 
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end


end