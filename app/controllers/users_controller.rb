class UsersController < ApplicationController
  before_action :set_user

  def show
    @documents = @user.documents
    @verifieds = @documents.verifieds
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

  def remove_avatar
    # if Cloudinary::Uploader.destroy(@user.avatar)
    if Cloudinary::Uploader.destroy(@user.avatar, type: :private)
      @user.update_column(:avatar, nil)
      flash[:notice] = 'Foto berhasil dihapuskan'
    else
      flash[:warning] = 'Foto gagal dihapuskan'
    end
    redirect_to user_root_path
  end


private
  def set_user
  	@user = User.friendly.find(params[:id])
  end

  def profile_params
  	params.require(:user).permit(
  	  :avatar, :image_id,
      :phone_number, :about, :last_education, :marital_status, 
      :address,
  	  	:work_experience, :occupation,
        :monthly_income, :monthly_expense,
        :number_dependents
  	)
  end

end