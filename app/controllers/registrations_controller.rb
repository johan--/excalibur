class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :resource_params, if: :devise_controller?
  before_filter :inside_app, only: [:edit]

  def new
    @no_layout = true
    super
  end

  def edit
    super
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
      meta_events_tracker.event!(:user, :signed_up, { auth: 'Kapiten' })
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
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