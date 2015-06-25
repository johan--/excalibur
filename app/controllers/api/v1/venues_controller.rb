class API::V1::VenuesController < API::V1::BaseController
  before_action :set_venue, only: [:show, :edit, :destroy]


  def index
    @venues = Venue.all.group_by { |v| v.province }
  end

  def show
  end

  def edit
  end

  def create
    @venue = Venue.new(venue_params)
    
    if @venue.save
      render json: @venue, status: 201, message: 'Arena berhasil dibuat'
    else
      render json: {error: "Arena gagal dibuat"}, status: 422
    end
  end

  def update        
    if @venue.update(venue_params)
      render json: @venue, status: 200, message: 'Arena berhasil dikoreksi'
    else
      render json: {error: "Arena gagal dikoreksi"}, status: 422
    end
  end

  def destroy
    @venue.destroy
    if @venue.destroy
      render json: {}, status: 200
    else
      render json: {error: "Arena gagal dihapus"}, status: 422
    end     
  end


  private
    def set_venue
      @venue = Venues.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(
        :name, :address, :province, :city, :phone, :firm_id
      )
    end
end