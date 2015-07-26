class ProfilesController < ApplicationController
  include ProfileSti
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_category
  before_action :user_layout

  def show
  end

  def new
    @profile = category_class.new
    @company = Team.find_by(id: params[:team]) if params[:team]

    respond_to do |format|
      format.html
      format.js
    end    
  end

  def edit
  end

  def create
    @profile = category_class.new(profile_params)
    @profile.category = @category
    @profile.profileable = current_user if @category == 'UserProfile'

    if @profile.save
      flash[:notice] = 'Profil berhasil dibuat'
      redirect_to user_root_path
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
      @profile = category_class.find(params[:id])
    end


    def profile_params
      params.require(category.underscore.to_sym).permit(
        :profileable, :profileable_type, :profileable_id, 
        :category, :about, 
        :details => [:last_education, :marital_status, 
          :industry_experience, :work_experience, :anno, :founding_size, 
          :online_presence_types => [], :offline_presence_types => []], 
        addresses_attributes: [:id, :_destroy, :profile_id, :name, 
        	:province, :full_address]
      )
    end
end