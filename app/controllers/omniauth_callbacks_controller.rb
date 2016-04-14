class OmniauthCallbacksController < Devise::OmniauthCallbacksController   

  def all
    auth = request.env["omniauth.auth"]
    @identity = Identity.find_by(uid: auth.uid, provider: auth.provider)    
    if @identity.nil?
      @identity = Identity.create_with_omniauth(auth) 
    end

    if signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it 
        # is the current user. So the identity is already associated with 
        # this user. So let's display an error message.
        # flash[:notice] = "Already linked that account!"
        redirect_to user_root_url, notice: "Already linked that account!"
      else
        # The identity is not associated with the current_user so lets 
        # associate the identity
        # @identity.user = current_user
        @identity.update_user_missing_info(current_user)
        @identity.save
        # flash[:notice] = "Successfully linked that account!"
        redirect_to user_root_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's 
        # just log them in here
        user = @identity.user
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        # No user associated with the identity so we need to create a new one
        user = User.from_omniauth(auth)
        if user.persisted?
          @identity.update(user: user)
          flash.notice = "Signed in!"
          sign_in_and_redirect user
          meta_events_tracker.event!(:user, :signed_up, { auth: @identity.provider })
        else
          @identity.destroy
          session["devise.user_attributes"] = user.attributes
          flash[:alert] = "Ada masalah, mohon coba lagi atau kontak admin"
          redirect_to new_user_registration_url
        end
      end
    end
  end

  alias_method :facebook, :all
  alias_method :linkedin, :all

  def after_sign_in_path_for(resource)
    super resource
  end

end

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

  # def all
  #   auth = request.env["omniauth.auth"]
  #   identity = Identity.from_omniauth(auth)
  #   user = identity.find_or_create_user(current_user)

  #   if user.persisted?
  #     flash[:notice] = "Signed in!"
  #     sign_in_and_redirect user
  #     meta_events_tracker.event!(:user, :signed_up, { auth: identity.provider })
  #   else
  #     flash[:alert] = "Ada masalah, mohon coba lagi atau kontak admin"
  #     redirect_to new_user_registration_url
  #   end
  # end