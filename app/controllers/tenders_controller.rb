class TendersController < ApplicationController
  before_action :set_tender, only: [:show, :edit, :update, :destroy]
  before_action :user_layout

  def index
    @tenders = current_user.tenders.all
  end

  def show
  end

  def new
    @type = params[:cat]
    @tender = current_user.tenders.build
  end

  def edit
  end

  def create
    @tender = current_user.tenders.build(tender_params)

    respond_to do |format|
      if @tender.save
        format.html { redirect_to user_root_path, notice: 'Pengajuan pembiayaan berhasil dilakukan' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tender.update(tender_params)
        format.html { redirect_to user_root_path, notice: 'Pengajuan pembiayaan berhasil dikoreksi' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tender.destroy
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Pengajuan pembiayaan berhasil dihapuskan' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tender
      @tender = current_user.tenders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tender_params
      params.require(:tender).permit(:category, :total)
    end
end
