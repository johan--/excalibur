class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:notice] = 'Profil berhasil diperbaharui'
      redirect_to user_root_path 
    else
      render :edit
    end   
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
  	@user = User.find(params[:id])
  end

  def profile_params
  	params.require(:user).permit(
  	  :phone_number, :about, :last_education, :marital_status, 
  	  	:work_experience, :industry_experience
  	)
  end

end