module API
  module V1
    class ReservationsController < ApplicationController
      before_action :set_reservation, only: [:show, :edit, :update, 
                                              :confirm]
      before_action :user_layout

      def index
        @reservations = current_user.reservations
      end

      def show
      end

      def edit
      end

      def create
        @reservation = Reservation.new(reservation_params)
        @reservation.booker = current_user
        
        if @reservation.save
          render 'show', formats: [:json], handlers: [:jbuilder], status: 201
          flash[:success] = 'Reservasi berhasil dibuat'
        else
          render json: {error: "Reservasi tidak bisa dibuat"}, status: 422
        end
      end

      def update        
        if @reservation.update(reservation_params)
          render 'show', formats: [:json], handlers: [:jbuilder], status: 200
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
          @reservation = current_user.reservations.find(params[:id])
        end

        def reservation_params
          params.require(:reservation).permit(
            :date_reserved, :start, :finish, :court_id, :court
          )
        end
    end
  end
end