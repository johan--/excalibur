class OmniauthCallbacksController < Devise::OmniauthCallbacksController   

  # def self.provides_callback_for(provider)
  #   class_eval %Q{
  #     def #{provider}
  #       @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         sign_in_and_redirect @user, event: :authentication
  #         set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #       else
  #         session["devise.#{provider}_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
  #     end
  #   }
  # end

  # [:facebook, :google_oauth2, :linked_in, :linkedin].each do |provider|
  #   provides_callback_for provider
  # end

  def all
    identity = Identity.from_omniauth(request.env["omniauth.auth"])
    user = identity.find_or_create_user(current_user)

    if user.valid?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      sign_in user
      redirect_to edit_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :linkedin, :all

  def after_sign_in_path_for(resource)
    super resource
    # Below conditional is for omniauth that does not provide email
    # if resource.email_verified?
    #   super resource
    # else
    #   finish_signup_path(resource)
    # end
  end

end