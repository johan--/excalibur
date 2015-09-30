class UsersController < ApplicationController
  before_action :set_user

  def show
    @documents = @user.documents
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:notice] = 'Profil berhasil diperbaharui'
      redirect_to user_root_path 
    else
      Rails.logger.info(@user.errors.inspect) 
      render :edit
    end   
  end

  def avatar
  end

  # def edit_profile
  # end

  # def update_profile
  #   if @user.update(profil_params)
  #     flash[:notice] = 'Profil berhasil diperbaharui'
  #     redirect_to user_root_path 
  #   else
  #     render :edit
  #   end  	
  # end


private
  def set_user
  	@user = User.friendly.find(params[:id])
  end

  def profile_params
  	params.require(:user).permit(
  	  :avatar, :image_id,
      :phone_number, :about, :last_education, :marital_status, :address,
  	  	:work_experience, :occupation,
        :monthly_income, :monthly_expense,
        :number_dependents
  	)
  end

end