class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :detect_device_format
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?
  before_filter :authenticate_user!, unless: :devise_controller?  

  def disable_nav
    @disable_nav = true
  end

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :phone_number,
      :full_name,
      :category,
      :investor, 
      :business
      )
    }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(
      :login, 
      :email,
      :phone_number,
      :password, 
      :remember_me
      ) 
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :phone_number,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    inside_path
  end

  # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!

  # Only permits admin users
  def require_admin!
    authenticate_user!

    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!

  def search_params
    params[:q]
  end

  def search_params_exist?
    return true if params[:q]
  end
  helper_method :search_params_exist?

  def clear_search_index
    if params[:search_cancel]
      params.delete(:search_cancel)
      if(!search_params.nil?)
        search_params.each do |key, param|
          search_params[key] = nil
        end
      end
    end
  end


private
  def detect_device_format
    case request.user_agent
    when /iPad/i
      request.variant = :tablet
    when /iPhone/i
      request.variant = :phone
    when /Android/i && /mobile/i
      request.variant = :phone
    when /Android/i
      request.variant = :tablet
    when /Windows Phone/i
      request.variant = :phone
    else
      request.variant = :desktop
    end
  end  
end
