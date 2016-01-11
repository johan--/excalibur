class Admin::HousesController < Admin::BaseController
  before_action :set_house, only: [:edit, :update, :destroy]

  def index
  	@houses = House.all.page params[:page]
  end

  def new
  	@house = House.new
  end

  def edit
  end

  def create
  	@house = House.new(house_params)
  	@house.publisher = current_user if params[:house][:publisher].nil?
  		
    if @house.save
      flash[:notice] = 'Rumah berhasil dibuat'
      redirect_to admin_houses_path
    else
      render :new 
    end  	
  end

  def update
  	if @house.update(house_params)
      flash[:notice] = 'Rumah berhasil dikoreksi'
      redirect_to admin_houses_path
  	else
  	  render :edit
  	end
  end

  def destroy
    @house.destroy
    flash[:notice] = 'Rumah berhasil dihapuskan'
    redirect_to admin_houses_path
  end

private
  def set_house
  	@house = House.friendly.find(params[:id])
  end

  def house_params
  	params.require(:house).permit(
  	  :price, :category, :state, :title, :address, :city, 
  	  :publisher, :publisher_type, :publisher_id,
  	  :bedrooms, :bathrooms, :kitchen, :level, :garages, :greenery,
  	  :property_size, :lot_size, :anno, :avatar
  	)
  end

end