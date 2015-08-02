class RegistrationsController < Devise::RegistrationsController
  before_action :user_layout, only: [:edit]

	# def create
	# 	super
	# 	if resource.save
	# 		if resource.business
	# 			redirect_to new_firm
	# 		elsif resource.investor
	# 		end
	# 	end
	# end

  protected

  def after_sign_up_path_for(resource)
    # if resource.operator?
    #   new_firm_path
    # else
      user_root_path
    # end
  end

end