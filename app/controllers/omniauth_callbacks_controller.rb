class OmniauthCallbacksController < Devise::OmniauthCallbacksController   

  # def self.provides_callback_for(provider)
  #   class_eval %Q{
  #     def #{provider}
  #       @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         sign_in_and_redirect @user, event: :authentication
  #         meta_events_tracker.event!(:user, :signed_up, { auth: #{provider} })
  #         set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #       else
  #         session["devise.#{provider}_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
  #     end
  #   }
  # end
  # [:facebook, :google_oauth2, :linkedin].each do |provider|
  #   provides_callback_for provider
  # end

  def all
    identity = Identity.from_omniauth(request.env["omniauth.auth"])
    user = identity.find_or_create_user(current_user)

    if user.persisted?
      flash[:notice] = "Signed in!"
      sign_in_and_redirect user
      meta_events_tracker.event!(:user, :signed_up, { auth: identity.provider })
    else
      flash[:alert] = "Ada masalah, mohon coba lagi atau kontak admin"
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :linkedin, :all

  def after_sign_in_path_for(resource)
    super resource
  end

end