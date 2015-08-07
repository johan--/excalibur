class BusinessesController < ApplicationController
  before_action :user_layout
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  
  def index
    @businesses = Business.all
  end

  def show
    @page = 'business'
    @tenders = @business.tenders
  end

  def new
    @business = Business.new
  end

  def edit
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      flash[:notice] = 'Bisnis berhasil didaftarkan' 
      redirect_to user_root_path
    else
      render :new 
    end
  end

  def update
    if @business.update(business_params)
      flash[:notice] = 'Profil bisnis berhasil diperbaharui' 
      redirect_to business_path(@business)
    else
      render :edit
    end
  end

  def destroy
    @business.destroy
    flash[:notice] =  'Business was successfully destroyed.' 
    redirect_to user_root_path
  end

  private
    def set_business
      @business = Business.friendly.find(params[:id])
    end

    def business_params
      params.require(:business).permit(
        :name, :slug,
          :anno, :founding_size, :about, :industry,
          :logo, :images,
          :city, :province, :address, 
          :online_presence_types => [], :offline_presence_types => []
      )
    end
end
