class ApplicationController < ActionController::Base
  include UrlHelper 
  include LayoutSelector
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :detect_device_format, unless: Proc.new { |c| c.request.format.json? }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?
  before_filter :authenticate_user!, unless: :devise_controller?  
  before_filter :disable_background, if: :devise_controller?
  before_filter :switch_browser_prompt, if: :devise_controller?

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :name,
      :phone_number,
      :understanding
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
      :name,
      :phone_number,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_url(subdomain: '')
    elsif resource.client? && !resource.financier?
      user_root_url(subdomain: '')
    elsif !resource.client? && resource.financier?
      firm_dashboard_url(subdomain: '')
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

  def switch_browser_prompt
    redirect_to upgrade_path if is_opera_mini?
  end

  def is_opera_mini?
    agent_strings = /Opera Mini|Opera Mobi|UBrowser/
    if request.env['HTTP_USER_AGENT']
      if request.env['HTTP_USER_AGENT'] =~ agent_strings
        true
      else
        false
      end
    end
  end
  helper_method :is_opera_mini?

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