class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy,
                                          :confirm]

  respond_to :html
  respond_to :js

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.booker = current_user
    
    respond_to do |format|
      if @reservation.save
        format.html do 
          # @reservation.state_machine.transition_to!(:confirmed)
          redirect_to user_root_path 
          flash[:notice] = 'Pemesanan berhasil dilakukan' 
        end
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to user_root_path, notice: 'Pemesanan berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Pesanan berhasil dihancurkan' }
      format.json { head :no_content }
    end
  end

def confirm
  if @reservation.state_machine.transition_to!(:confirmed)
    flash[:notice] = "Success"
    redirect_to user_root_path
  else
    flash[:error] = "Could not transition to 'received'"
    redirect_to user_root_path
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:date_reserved, :start, 
        :duration, :finish, :court_id)
    end
end
