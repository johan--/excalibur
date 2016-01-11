class Admin::HousesController < Admin::BaseController

  def index
  	@houses = House.all.page params[:page]
  end

  def new
  	@house = House.new
  end

  def create
  	@house = House.new(house_params)
  	@house.publisher = current_user if params[:house][:publisher].nil?
  		
    if @house.save
      flash[:notice] = 'Proposal berhasil dibuat'
      redirect_to @house
    else
      render :new 
    end  	
  end


private

  def house_params
  	params.require(:house).permit(
  	  :price, :category, :state, :title, :address, :city, 
  	  :publisher, :publisher_type, :publisher_id,
  	  :bedrooms, :bathrooms, :kitchen, :level, :garages, :garden,
  	  :property_size, :lot_size, :anno
  	)
  end

end