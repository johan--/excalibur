class Admin::TendersController < Admin::BaseController
  before_action :set_tender, only: [:update]

  def index
    @admin = true
    @tenders = Tender.order(:created_at).page params[:page]
  end

  def update
    if @tender.update(tender_params)
      @tender.transitioning!
      flash[:notice] = 'Dokumen berhasil dikoreksi'
      redirect_to admin_tenders_path 
    else
      flash[:warning] = 'Dokumen gagal dikoreksi'
      render :index
    end    
  end

  private

  def set_tender
    @tender = Tender.friendly.find(params[:id])
  end

  def tender_params
    params.require(:tender).permit(
    :checked,
    :flagged,
    :public_id
    )
  end

end