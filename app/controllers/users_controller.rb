class UsersController < ApplicationController
  before_filter :inside_app
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
    # if @user.update_attributes(profile_params)
    #   # if params[:avatar]
    #   #   ahoy.track "Uploaded avatar", 
    #   #     title: "#{@user.name}: #{@user.avatar}", 
    #   #     category: "User", important: "avatar"
    #   # else
    #   #   ahoy.track "Edited user profile", title: "#{@user.name}", 
    #   #     category: "User", important: "profile"
    #   # end
    #   flash[:notice] = 'Profil berhasil diperbaharui'
    # else
    #   flash[:warning] = 'Profil gagal diperbaharui'
    #   # Rails.logger.info(@user.errors.inspect) 
    # end   
    # redirect_to user_root_path 

    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to user_root_path, notice: 'Profil berhasil diperbaharui' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
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