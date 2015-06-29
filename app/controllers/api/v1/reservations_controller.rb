class API::V1::ReservationsController < API::V1::BaseController
  before_action :set_reservation, only: [:show, :edit, :update, 
                                         :destroy, :confirm]

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
  param :reservation, Hash do
    param :date_reserved, String, "Email of the user", required: true
    param :start, String, "Password of the user", required: true
    param :duration, Decimal, "Password confirmation of the user", required: true
    param :court_id, Integer, "Name of the user", required: true
  end
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.booker = @current_user
    
    if @reservation.save
      render json: @reservation, status: 201, message: 'Reservasi berhasil dibuat'
    else
      render json: {error: "Reservasi tidak bisa dibuat"}, status: 422
    end
  end

  def update        
    if @reservation.update(reservation_params)
      render json: @reservation, status: 200, message: 'Reservasi berhasil dikoreksi'
    else
      render json: {error: "Reservasi gagal dikoreksi"}, status: 422
    end
  end

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
