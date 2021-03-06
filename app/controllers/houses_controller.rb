class HousesController < ApplicationController
  impressionist :actions=> [:show]
  before_filter :inside_app, except: :show
  before_action :set_house, only: [:show, :edit,
                    :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :show ]

  def index
    @houses = House.all.page params[:page]
  end

  def show 
    set_as_static
    @photos = @house.photos
    @view_count = @house.impressionist_count(:filter=>:session_hash)
    unless user_signed_in? && @house.access_granted?(current_user)
      impressionist(@house)
      meta_events_tracker.event!(:visit, :house, { house_ticker: "RUM#{@house.ticker}", city: @house.city, price: @house.price_sens, referrer: request.referrer } )
    end
    @hash = Gmaps4rails.build_markers(@house) do |house, marker|
      marker.lat house.latitude
      marker.lng house.longitude
    end    
  end

  def edit
    @house = House.friendly.find(params[:id])
    redirect_to house_step_path(@house, @house.form_step) if @house.input_unfinished?
  end


  def create
    if params[:build]
      @house = House.new(form_step: House.form_steps.first, publisher: current_user)
    else
      @house = House.new(house_params)
      @house.publisher = current_user 
    end

    if @house.save
      flash[:notice] = 'Rumah mulai didaftarkan'
      redirect_to house_step_path(@house, House.form_steps.first)
    else
      render :new 
    end   
  end

  def update
    if @house.update(house_params)
      flash[:notice] = 'Rumah berhasil dikoreksi'
      redirect_to house_path(@house)
    else
      render :edit
    end
  end

  def destroy
    @house.destroy
    flash[:notice] = 'Rumah berhasil dihapuskan'
    redirect_to user_root_path
  end

private
  def set_house
    @house = House.friendly.find(params[:id])
  end

  def house_params
    params.require(:house).permit(
      :price, :category, 
      :province, :title, :address, :address_was, :city, :complex,
      :publisher, :publisher_type, :publisher_id,
      :bedrooms, :bathrooms, :kitchen, :level, :garages, 
      :description, :form_step, 
      :property_size, :lot_size, :anno, :avatar,
      :photos_attributes => [:id, :signature, :created_at, 
        :tags, :bytes, :type, :etag, :url, :secure_url, 
        :original_filename],
      photos: []
      # {photos: []} failed,
      # photos: [] failed
    )
  end

end