class ApplicationController < ActionController::Base
  include UrlHelper 
  include LayoutSelector
  include Analyticable
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with:  :null_session
  before_action :detect_device_format, unless: Proc.new { |c| c.request.format.json? }
  before_filter :reject_locked!, if: :devise_controller?
  # before_filter :store_location
  before_filter :authenticate_user!#, unless: :devise_controller?  
  before_filter :disable_background, if: :devise_controller?
  before_filter :switch_browser_prompt, if: :devise_controller?
  # before_filter :set_locale
  # before_filter :resource_params, if: :devise_controller?


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


  def switch_browser_prompt
    redirect_to upgrade_path if is_opera_mini?
  end

  def is_opera_mini?
    agent_strings = /Opera Mini|Opera Mobi|UBrowser|UCBrowser/
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

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  # def set_locale
  #   # I18n.locale = params[:locale] if params[:locale].present?
  #   # I18n.locale = current_user.locale # alternative 1
  #   # I18n.locale = request.subdomain  # alternative 2
  #   if cookies[:user_locale] && I18n.available_locales.include?(cookies[:user_locale].to_sym)
  #     l = cookies[:user_locale].to_sym
  #   else
  #     l = I18n.default_locale
  #     cookies.permanent[:user_locale] = l
  #   end
  #   I18n.locale = l    
  # end
end