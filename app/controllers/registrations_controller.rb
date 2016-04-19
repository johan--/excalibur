class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :resource_params
  before_filter :inside_app, only: [:edit]

  def new
    set_as_static
    super
  end

  def edit
    super
  end

  def create
    super
    if resource.save
      meta_events_tracker.event!(:user, :signed_up, { auth: 'Kapiten' })
    end
  end


  private

  def after_sign_up_path_for(resource)
    if resource.admin?
      admin_root_url(subdomain: '')
    else
      user_root_url(subdomain: '')
    end          
  end

  def resource_params
    devise_parameter_sanitizer.for(:sign_up) {|user| user.permit(
      :first_name, :last_name, :email, :password, :password_confirmation,
      :understanding, :phone_number, :location, :name, :avatar,
      :auth_with
      )
    }
    devise_parameter_sanitizer.for(:account_update) {|user| user.permit(
      :first_name, :last_name, :email, :phone_number,
      :password, :password_confirmation, :current_password
      )
    }
  end
  
end