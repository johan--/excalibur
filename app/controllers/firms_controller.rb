class FirmsController < ApplicationController

  def index
    @firm_search = Firm.search(search_params)
    @firms = @firm_search.result
  end

  # GET /firms/new
  def new
    @firm = Firm.new
  end

  # POST /firms
  # POST /firms.json
  def create
    @firm = Firm.new(firm_params)

    if @firm.save
      @member = @firm.rosters.build(
      user: current_user, role: 0, state: "aktif")
      @sub =  @firm.build_subscription(category: 1, 
                            start_date: Date.today, state: "aktif")
        if @member.save && @sub.save
          redirect_to biz_root_path
          flash[:notice] = 'Bisnismu berhasil didaftarkan'
        else
          render :new 
          flash[:warning] = 'Bisnismu gagal didaftarkan, coba lagi'
        end
    else
      render :new 
    end
  end

  def join
    set_firm
    @member = @firm.rosters.build(
    user: current_user, role: 2, state: "menunggu")

      if @member.save
        redirect_to posts_path
        flash[:notice] = 'Tunggu konfirmasi dari moderator bisnis ini'
      else
        render :new 
        flash[:warning] = 'Kamu gagal bergabung, coba lagi'
      end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firm
      @firm = Firm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firm_params
      params.require(:firm).permit(
        :name, :region, :city, :address, :phone,
        subscription_attributes: [
          :id, :firm_id, :category, :start_date, :state]
      )
    end
end
