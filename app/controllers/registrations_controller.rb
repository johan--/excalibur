class RegistrationsController < Devise::RegistrationsController
  before_action :user_layout, only: [:edit]

  def create
    # unless Subscriber.whitelist.exists?(:email => params[:user][:email])
    #   redirect_to new_user_registration_path
    #   flash[:alert] = "Maaf, emailmu tidak masuk dalam daftar pengguna Beta"
    # else
      super 
    # end
  end

  protected

  def after_sign_up_path_for(resource)
    if resource.admin?
      admin_root_url(subdomain: '')
    elsif resource.client? && !resource.financier?
      user_root_url(subdomain: '')
    elsif !resource.client? && resource.financier?
      firm_root_url(subdomain: '')
    else
      user_url(resource)
    end          
  end

end