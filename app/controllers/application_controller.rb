class ApplicationController < ActionController::Base
  include UrlHelper 
  include LayoutSelector
  include GuestsHelper
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :detect_device_format, unless: Proc.new { |c| c.request.format.json? }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?
  before_filter :authenticate_user!, unless: :devise_controller?  
  before_filter :normal_nav, if: :devise_controller?
  
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        guest_user(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end
  helper_method :current_or_guest_user
  
  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :name
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
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    user_root_path
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


private
  # # called (once) when the user logs in, insert any code your application needs
  # # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save!
    # end
  end

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