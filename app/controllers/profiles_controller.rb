class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  	@profile_type = params[:profile_for]
	  @profile = Profile.new
	  @profile.addresses.build
  end

  def edit
  	@profile_type = params[:profile_for]
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      if @profile.profileable_type == 'Firm'
        flash[:notice] = 'Profil Usaha berhasil dibuat'
        redirect_to user_root_path
      else
        flash[:notice] = 'Profil Pengguna berhasil dibuat'
        redirect_to view_account_path
      end
    else
      flash[:warning] = 'Profil gagal dibuat'
      return render 'new'
    end     
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to view_account_path, notice: 'Profil berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end


    def profile_params
      params.require(:profile).permit(
        :about, :details, :profileable_type, :profileable_id,
        addresses_attributes: [:id, :_destroy, :profile_id, :name, 
        	:province, :full_address]
      )
    end
end