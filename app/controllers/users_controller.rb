class UsersController < ApplicationController
  before_action :set_user

  def show
    @documents = @user.documents
    @groups = @documents.group_by { |doc| doc.category }
    @verifieds = @documents.verifieds

    unless current_user == @user || current_user.admin?
      # ahoy.track "Viewed user profile", 
      #   title: "#{current_user.name} viewed #{@user.name}", 
      #   category: "User", important: "profile"
    end    
  end

  def edit
  end

  def update
    if @user.update_attributes(profile_params)
      if params[:avatar]
        ahoy.track "Uploaded avatar", 
          title: "#{@user.name}: #{@user.avatar}", 
          category: "User", important: "avatar"
      else
        ahoy.track "Edited user profile", title: "#{@user.name}", 
          category: "User", important: "profile"
      end
      flash[:notice] = 'Profil berhasil diperbaharui'
    else
      flash[:warning] = 'Profil gagal diperbaharui'
      # Rails.logger.info(@user.errors.inspect) 
    end   
    redirect_to user_root_path 
  end

  def avatar
  end

  def remove_avatar
    # if Cloudinary::Uploader.destroy(@user.avatar)
    if Cloudinary::Uploader.destroy(@user.avatar, type: :private)
      @user.update_column(:avatar, nil)
      # ahoy.track "Removed avatar", title: "#{@user.name}: #{@user.avatar}",
      #   category: "User", important: "avatar"
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
      :id, :avatar, :image_id,
      :phone_number, :about, :last_education, :marital_status, 
      :address, :work_experience, :occupation,
      :monthly_income, :monthly_expense, :number_dependents
  	)
  end

end