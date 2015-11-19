class Admin::BidsController < Admin::BaseController
  before_action :set_bid, only: [:edit, :update]

  def index
    @admin = true
    if params[:tender_id]
      @tender = Tender.friendly.find(params[:tender_id])
      @bids = Bid.where(tender: @tender).page params[:page]
    else
      @bids = Bid.order(:created_at).page params[:page]
    end
  end

  def edit
  end

  def update
    if @bid.update(bid_params)
      flash[:notice] = 'Tawaran berhasil diproses'
      redirect_to admin_bids_path 
    else
      flash[:warning] = 'Tawaran gagal diproses'
      render :index
    end    
  end

  private

  def set_bid
    @bid = Bid.friendly.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(
      :state, :shares
    )
  end

end