class SessionsController < Devise::SessionsController
  before_filter :resource_params
  skip_before_filter :authenticate_user!
  
  def new
    @no_layout = true
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
    if resource.admin?
      admin_root_url(subdomain: '')
    else
      user_root_url(subdomain: '')
    end      
  end      
end