class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :inside_app, only: [:edit]

  def new
    @no_layout = true
    super
  end

  def edit
    super
  end

  def create
    super
    if resource.save
      meta_events_tracker.event!(:user, :signed_up, { auth: 'Kapiten' })
    end
  end


  private

  def after_sign_up_path_for(resource)
    if resource.admin?
      admin_root_url(subdomain: '')
    else
      user_root_url(subdomain: '')
    end          
  end  
end