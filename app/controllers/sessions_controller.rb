class SessionsController < Devise::SessionsController
  before_filter :resource_params
  skip_before_filter :authenticate_user!
  
  def new
    set_as_static
    super  	
  end

  private

  def resource_params
    devise_parameter_sanitizer.for(:sign_in) {|user| user.permit(
      	# :login, # :phone_number, 
      	:email,:password, :remember_me
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    # if resource.admin?
    #   admin_root_url(subdomain: '')
    # else
    #   session["user_return_to"] || user_root_url(subdomain: '')
    # end      
    sign_in_url = new_user_session_url
    # basic_root = 
    if request.referer == sign_in_url
      if resource.admin? then admin_root_path else super end 
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end


end