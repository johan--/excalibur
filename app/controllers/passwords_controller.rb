class PasswordsController < Devise::PasswordsController
  skip_before_action :authenticate_user!
  before_filter :set_as_static, only: [:show]

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
  
  def after_resetting_password_path_for(resource)
    signed_in_root_path(resource)
  end
end