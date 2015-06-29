class API::V1::InstallmentsController < API::V1::BaseController
  before_action :set_installment, only: [:show, :update]

  def show
  end

  def create
	@installment = @current_user.installments.build(installment_params)

    if @installment.save
      render json: @installment, status: 201, message: 'Pembayaran berhasil dibuat'
    else
      render json: {error: "Pembayaran gagal dibuat"}, status: 422
    end  	
  end

  def update        
    if @installment.update(installment_params)
      render json: @installment, status: 200, message: 'Pembayaran berhasil dikoreksi'
    else
      render json: {error: "Pembayaran gagal dikoreksi"}, status: 422
    end
  end



private
  def set_installment
  	@installment = @current_user.installments.find(params[:id])
  end

  def installment_params
  	params.require(:installment).permit(
  	  :reservation_id, :pay_day, :pay_time, :pay_code, :total
  	)
  end

end