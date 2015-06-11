class VenuesController < ApplicationController
  before_action :set_venue, only: :show
  before_action :user_layout

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all.group_by { |v| v.province }
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @rev_search = Reservation.search(search_params)
    @reservations = @rev_search.result
    @reservation = Reservation.new
    @date_group = Reservation.by_venue(@venue).upcoming.group_by { |r| r.date_reserved }
    @court_group = Reservation.by_venue(@venue).in_seven.group_by { |r| r.court }
  end

  def bookings
    @date_group = Reservation.by_venue(@venue).upcoming.group_by { |r| r.date_reserved }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.includes(:courts).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(
        :name, :address, :province, :city, :phone, :firm_id)
    end
end
