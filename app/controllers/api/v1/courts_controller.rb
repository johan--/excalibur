class API::V1::CourtsController < API::V1::BaseController
  before_action :set_venue
  before_action :set_court, only: [:show, :edit, :update, 
                                         :destroy]

  def index
    @courts = @venue.courts
  end

  def show
  end

  def edit
  end

  def create
    @court = @venue.courts.build(court_params)
    
    if @court.save
      render json: @court, status: 201, message: 'Lapangan berhasil dibuat'
    else
      render json: {error: "Lapangan gagal dibuat"}, status: 422
    end
  end

  def update        
    if @court.update(court_params)
      render json: @court, status: 200, message: 'Lapangan berhasil dikoreksi'
    else
      render json: {error: "Lapangan gagal dikoreksi"}, status: 422
    end
  end

  def destroy
    @court.destroy
    if @court.destroy
      render json: {}, status: 200
    else
      render json: {error: "Lapangan gagal dihapus"}, status: 422
    end          
  end


  private
    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

    def set_court
      @court = @venue.courts.find(params[:id])
    end

    def court_params
      params.require(:court).permit(
        :name, :price, :unit, :category, :venue_id
      )
    end
end