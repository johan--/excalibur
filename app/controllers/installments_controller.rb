class InstallmentsController < ApplicationController
  before_action :set_installment, only: [:show, :edit, :update]
  before_action :user_layout

  def index
    @installments = current_user.installments
  end

  def show
  end

  def new
    @installment = current_user.installments.build
  end

  def edit
  end

  def create
    @installment = current_user.installments.build(installment_params)

    respond_to do |format|
      if @installment.save
        format.html { redirect_to user_root_path, notice: 'Pembayaran berhasil dicatat' }
        format.json { render :show, status: :created, location: @installment }
      else
        format.html { render :new }
        format.json { render json: @installment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @installment.update(installment_params)
        format.html { redirect_to user_root_path, notice: 'Pembayaran berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @installment }
      else
        format.html { render :edit }
        format.json { render json: @installment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @installment.destroy
    respond_to do |format|
      format.html { redirect_to installments_url, notice: 'Installment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installment
      @installment = current_user.installments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installment_params
      params.require(:installment).permit(
        :reservation_id, :pay_day, :pay_time, :pay_code, :total
      )
    end
end
