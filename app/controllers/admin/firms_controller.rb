class Admin::FirmsController < Admin::BaseController
  before_filter :set_firm, only: [:show, :new, :edit, :update, :destroy]
  
  def index
    @firms = Firm.all
  end

  def show
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)
  end

  def edit
  end


  private

  def set_firm
    @firm = Firm.find(params[:id])
  end

  def firm_params
    params.require(:firm).permit(
      :name, :state, :profile, :preferences
    )
  end

end
