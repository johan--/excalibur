class Admin::ReservationsController < Admin::BaseController
  before_action :set_reservaton, only: :show

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def edit
  end


  private

  def set_reservaton
    @reservation = Reservation.find(params[:id])
  end

  # def user_params
  #   params.require(:user).permit(
  #   :email,
  #   :password,
  #   :admin,
  #   :locked
  #   )
  # end

end
