class API::V1::ReservationsController < API::V1::BaseController
  before_action :set_reservation, only: [:show, :edit, :update, 
                                         :destroy, :confirm]
  def_param_group :reservation do
    param :reservation, Hash, required: true do
      param :date_reserved, String, "Date of the booking", required: true
      param :start, String, "Reservation start hour in format of 00:00-23:59", required: true
      param :duration, String, "Duration of booking in decimal hour(s): 1.0, 1.5, 2.0, 2.5, etc", required: true
      param :court_id, Integer, "Id of the court used", required: true    
    end
  end                                         

  api :GET, "/reservations", "List all reservations made by the current user"
  description "List all the reservations made by the current user (the authenticated user)"
  def index
    @reservations = @current_user.reservations
  end

  api :GET, "/reservations/:id", "Show a single reservation"
  description "Show a single reservation made by current user and its attributes"
  def show
  end

  api :POST, "/reservations", "Create a new reservation"
  description "Create reservation by the current user"
  param_group :reservation
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.booker = @current_user
    
    if @reservation.save
      render json: @reservation, status: 201, message: 'Reservasi berhasil dibuat'
    else
      render json: {error: "Reservasi tidak bisa dibuat"}, status: 422
    end
  end

  api :PUT, "/reservations/:id", "Update an existing reservation"
  description "Update a reservation made by the current user"
  param_group :reservation
  def update        
    if @reservation.update(reservation_params)
      render json: @reservation, status: 200, message: 'Reservasi berhasil dikoreksi'
    else
      render json: {error: "Reservasi gagal dikoreksi"}, status: 422
    end
  end

  api!
  def destroy
    @reservation.destroy
    if @reservation.destroy
      render json: {}, status: 200
    else
      render json: {error: "Reservasi gagal dihapus"}, status: 422
    end          
  end


  private
    def set_reservation
      @reservation = @current_user.reservations.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(
        :date_reserved, :start, :duration, 
        :court_id, :court#, :booker, :booker_type, :booker_id
      )
    end
end
