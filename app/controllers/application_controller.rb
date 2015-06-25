class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_action :detect_device_format, unless: Proc.new { |c| c.request.format.json? }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?
  before_filter :authenticate_user!, unless: :devise_controller?  
  before_filter :normal_nav, if: :devise_controller?
  

  def disable_nav
    @disable_nav = true
  end
  def normal_nav
    @normal_nav = true
  end  
  def firm_layout
    @firm_layout = true
  end
  def user_layout
    @user_layout = true
  end
  def admin_layout
    @admin_layout = true
  end

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :category,
      :email,
      :password,
      :password_confirmation,
      # :phone_number,
      :full_name
      )
    }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(
      # :login, 
      :email,
      # :phone_number,
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
    if resource.operator?
      if resource.with_no_firm?
        new_firm_path
      else
        biz_root_path
      end
    else
      user_root_path
    end
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
      redirect_to user_root_path
    end
  end
  helper_method :require_admin!

  # Only permits operator users
  def require_operator!
    if !current_user.operator?
      redirect_to user_root_path
    elsif current_user.with_no_firm?
      redirect_to posts_path
    end
  end
  helper_method :require_operator!

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
