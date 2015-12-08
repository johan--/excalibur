class RegistrationsController < Devise::RegistrationsController
  before_action :user_layout, only: [:edit]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      # track! :signup #, resource.role_number # track successful sign up
      
      # if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      # else
      #   set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      #   expire_data_after_sign_in!
      #   respond_with resource, location: after_inactive_sign_up_path_for(resource)
      # end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
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