class Biz::CourtsController < Biz::BaseController
  before_action :set_court

  def preferences    
  end

  def save_preferences
    @primeday = @court.settings(:primeday).update_attributes!(
        state: pref_params[:day_state], active: pref_params[:day_active],
        increase: pref_params[:day_increase]        
      )
    @primetime = @court.settings(:primetime).update_attributes!(
        state: pref_params[:time_state], start_at: pref_params[:time_start],
        end_at: pref_params[:time_end],
        increase: pref_params[:time_increase]        
      )
    
    flash[:notice] = "Preferensi #{@court.name} berhasil dikoreksi"
    redirect_to biz_root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_court
      @venue = @firm.venues.find(params[:venue_id])
      @court = @venue.courts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pref_params
      params.require(:court_pref).permit(
        :day_state, :day_active, :day_increase,
        :time_state, :time_start, :time_end, :time_increase
      )
    end


end