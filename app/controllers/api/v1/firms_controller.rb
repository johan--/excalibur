class API::V1::FirmsController < API::V1::BaseController
  before_action :check_user
  before_action :check_access, only: [:show]

  def index
  	@firms = Firm.all
  end

  def show
  end

  def create
    @firm = Firm.new(firm_params)
    
    if @firm.save
      render json: @firm, status: 201, message: 'Bisnismu berhasil didaftarkan'
    else
      render json: {error: "Bisnis gagal dibuat"}, status: 422
    end
  end

  def update        
  	@firm = Firm.find(params[:id])
    if @firm.update(firm_params)
      render json: @firm, status: 200, message: 'Bisnismu berhasil dikoreksi'
    else
      render json: {error: "Bisnis gagal dikoreksi"}, status: 422
    end
  end


private
  def check_user
  	unless @current_user.operator?
  	  render json: { errors: "Not have any access" }, status: 401	
  	end
  end

  def check_access
    @firm = Firm.find(@current_user.firm_locator.id)
    if @firm.nil?
      render json: { errors: "Not have any access" }, status: :unauthorized
    end
  end

  def firm_params
    params.require(:firm).permit(
      :name, :region, :city, :address, :phone
    )
  end

end