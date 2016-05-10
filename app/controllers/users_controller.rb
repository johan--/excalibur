class UsersController < ApplicationController
  before_filter :inside_app
  before_action :set_user
  
  def show
    @tenders_count = current_user.tenders.count
    @documents = @user.documents
    # @groups = Document.categories
    @verifieds = @documents.verifieds
  end

  def edit
    @documents = current_user.documents
    @document = current_user.documents.build
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = 'Profil berhasil diperbaharui'
      redirect_to user_path(current_user)
    else
      flash[:warning] = 'Profil gagal diperbaharui'
      render :edit
    end
  end

  def avatar
  end

  def remove_avatar
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

  def user_params
    accessible = [ :name, :email, :phone_number, :avatar ] # extend with your own params
    accessible << profile_params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)    
  end

  def profile_params
    [ :image_id, :about, :last_education, :marital_status, 
    :address, :work_experience, :occupation,
    :monthly_income, :monthly_expense, :number_dependents ]
  end

end