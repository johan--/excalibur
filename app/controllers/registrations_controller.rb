class RegistrationsController < Devise::RegistrationsController
  before_action :user_layout, only: [:edit]

  def create
    unless Subscriber.exists?(:email => params[:user][:email])
      redirect_to new_user_registration_path
      flash[:alert] = "Maaf, emailmu tidak masuk dalam daftar pengguna Beta"
    else
      super  
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_root_path
  end

end