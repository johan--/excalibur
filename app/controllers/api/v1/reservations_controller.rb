class API::V1::ReservationsController < API::V1::BaseController
  before_action :set_reservation, only: [:show, :edit, :update, 
                                         :destroy, :confirm]

  def index
    # @reservations = @current_user.reservations
    @reservations = Reservation.all
  end

  def show
  end

  def edit
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
