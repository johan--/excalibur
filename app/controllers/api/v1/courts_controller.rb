class API::V1::CourtsController < API::V1::BaseController
  before_action :set_court, only: [:show, :update]

  def_param_group :court do
    param :court, Hash, required: true do
      param :name, String, "Name of the court", required: true
      param :price, String, "The cost of reservation", required: true
      param :unit, String, "Unit of reservation, default is 'Jam'", required: true
      param :category, String, "Category of the court", required: true
      param :venue_id, Integer, "Id of the venue of the court", required: true
    end
  end


  api :GET, "/courts/:id", "Look into a court of a venue"
  description "Show attributes of a court"
  def show
  end

  api :POST, "/courts", "Create a new court"
  description "Create a new court"
  param_group :court
  def create
    @court = Court.new(court_params)
    
    if @court.save
      render json: @court, status: 201, message: 'Lapangan berhasil dibuat'
    else
      render json: {error: "Lapangan gagal dibuat"}, status: 422
    end
  end

  api :PUT, "/courts/:id", "Update an existing court"
  description "Update attributes of an existing court"
  param_group :court
  def update        
    if @court.update(court_params)
      render json: @court, status: 200, message: 'Lapangan berhasil dikoreksi'
    else
      render json: {error: "Lapangan gagal dikoreksi"}, status: 422
    end
  end

  # def destroy
  #   @court.destroy
  #   if @court.destroy
  #     render json: {}, status: 200
  #   else
  #     render json: {error: "Lapangan gagal dihapus"}, status: 422
  #   end          
  # end


  private
    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

    def set_court
      @court = Court.find(params[:id])
    end

    def court_params
      params.require(:court).permit(
        :name, :price, :unit, :category, :venue_id
      )
    end
end