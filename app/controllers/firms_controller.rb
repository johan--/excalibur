class FirmsController < ApplicationController
  before_action :normal_nav

  def index
    @firm_search = Firm.search(search_params)
    @firms = @firm_search.result
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)

    if @firm.save
      @firm.starting_up(current_user)
      redirect_to biz_root_path
      flash[:notice] = 'Bisnismu berhasil didaftarkan'
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
        :name, :region, :city, :address, :phone
      )
    end
end
