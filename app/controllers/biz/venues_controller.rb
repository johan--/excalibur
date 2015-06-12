class Biz::VenuesController < Biz::BaseController
  before_action :set_venue, only: [:show, :edit, :update, :destroy, 
    :preferences, :save_preferences]

  respond_to :html, :js

  def show
  end

  def new
  	@venue = @firm.venues.build
  	@venue.courts.build
  end

  def create
  	@venue = @firm.venues.build(venue_params)
    respond_to do |format|
      if @venue.save
        format.html { redirect_to biz_root_path, notice: 'Arena berhasil didaftarkan' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end  	
  end

  def edit
  end

  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to biz_root_path, notice: 'Arena berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end  	
  end

  def preferences    
  end

  def save_preferences
    @primeday = @venue.settings(:primeday).update_attributes!(
        state: pref_params[:day_state], active: pref_params[:day_active],
        increase: pref_params[:day_increase]        
      )
    @primetime = @venue.settings(:primetime).update_attributes!(
        state: pref_params[:time_state], start_at: pref_params[:time_start],
        end_at: pref_params[:time_end],
        increase: pref_params[:time_increase]        
      )
    
    flash[:notice] = 'Preferensi Arena berhasil dikoreksi'
    redirect_to biz_root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = @firm.venues.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(
        :firm_id, :name, :address, :province, :city, :phone,
        courts_attributes: [:id, :venue_id, :name, :price, :unit,
        	:category, :_destroy]
      )
    end

    def pref_params
      params.require(:venue_pref).permit(
        :day_state, :day_active, :day_increase,
        :time_state, :time_start, :time_end, :time_increase
      )
    end

end