class Biz::PaymentsController < Biz::BaseController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]


  def show
  end


  def new
    @payment = @firm.subscription.payments.build
  end

  # GET /payments/1/edit
  def edit
  end


  def create
    @payment = @firm.subscription.payments.build(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to biz_subscription_path, notice: 'Pembayaran berhasil dicatat, tunggu konfirmasi' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to biz_subscription_path, notice: 'Pembayaran berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @payment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @subscription = @firm.subscription
      @payment = @subscription.payments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(
        :pay_code, :pay_day, :pay_time, :total
      )
    end
end
