class RegistrationsController < Devise::RegistrationsController
  before_filter :resource_params, if: :devise_controller?
  skip_before_filter :authenticate_user!, unless: [:edit, :update]

  def new
    @no_layout = true
    super
  end

  def edit
    super
    inside_app
  end

  def create
    unless Subscriber.exists?(email: params[:email])
      errors.add :email, "is not on our beta list"
    else
      super
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