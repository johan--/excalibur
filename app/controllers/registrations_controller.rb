class RegistrationsController < Devise::RegistrationsController
  include Analyticable
  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :resource_params
  before_filter :inside_app, only: [:edit]
  after_filter  :after_registration, :only => :create

  def new
    set_as_static
    super
  end

  def edit
    super
  end

  def create
    super
  end


private

  def after_registration
    if resource.persisted?
      meta_events_tracker.event!(:user, :signed_up, { auth: 'Kapiten', user_agent: request.user_agent })
      mixpanel_tracker.alias(current_user.id, current_browser_id)
    end
  end

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
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