class Admin::FirmsController < Admin::BaseController
  
  def index
    @firms = Firm.all
  end

  def show
  end

  def edit
  end


  private

  def set_firm
    @firm = Firm.find(params[:id])
  end

  # def user_params
  #   params.require(:user).permit(
  #   :email,
  #   :password,
  #   :password_confirmation,
  #   :admin,
  #   :locked
  #   )
  # end

end
