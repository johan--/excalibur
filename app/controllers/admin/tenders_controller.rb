class Admin::TendersController < Admin::BaseController
  before_action :set_tender, only: [:edit, :update]

  def index
    @admin = true
    @tenders = Tender.order(:created_at).page params[:page]
  end

  def edit
  end

  def update
    if @tender.update(tender_params)
      # @tender.transitioning!
      flash[:notice] = 'Proposal berhasil diproses'
      redirect_to admin_tenders_path 
    else
      flash[:warning] = 'Proposal gagal diproses'
      render :index
    end    
  end

  private

  def set_tender
    @tender = Tender.friendly.find(params[:id])
  end

  def tender_params
    params.require(:tender).permit(
      :summary
    )
  end

end