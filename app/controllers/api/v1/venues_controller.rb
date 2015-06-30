class API::V1::VenuesController < API::V1::BaseController
  before_action :set_venue, only: [:show, :update, :destroy]

  def_param_group :venue do
    param :venue, Hash, required: true do
      param :name, String, "Name of the venue", required: true
      param :address, String, "Full address of the venue", required: true
      param :province, String, "Province of the venue", required: true
      param :city, String, "City of the venue", required: true
      param :phone, String, "Primary phone number", required: true
      param :firm_id, Integer, "Id of the firm account that operates the venue", required: true
    end
  end

  api :GET, "/venues/", "Look into a list of venues based on province"
  description "Show a group of venues"
  def index
    @venues = Venue.all.group_by { |v| v.province }
  end

  api :GET, "/venues/:id", "Look into a venue"
  description "Show attributes of a venue"
  def show
  end

  api :POST, "/venues", "Create a new venue"
  description "Create a new venue"
  param_group :venue
  def create
    @venue = Venue.new(venue_params)
    
    if @venue.save
      render json: @venue, status: 201, message: 'Arena berhasil dibuat'
    else
      render json: {error: "Arena gagal dibuat"}, status: 422
    end
  end

  api!
  param_group :venue
  def update        
    if @venue.update(venue_params)
      render json: @venue, status: 200, message: 'Arena berhasil dikoreksi'
    else
      render json: {error: "Arena gagal dikoreksi"}, status: 422
    end
  end

  # def destroy
  #   @venue.destroy
  #   if @venue.destroy
  #     render json: {}, status: 200
  #   else
  #     render json: {error: "Arena gagal dihapus"}, status: 422
  #   end     
  # end


  private
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(
        :name, :address, :province, :city, :phone, :firm_id
      )
    end
end