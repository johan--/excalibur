class Admin::DealsController < Admin::BaseController
  before_action :set_deal, only: [:show, :edit, :update]

  def index
    @admin = true
    @deals = Deal.order(:created_at).page params[:page]
  end

  def show
  end

  def new
    @tender = Tender.friendly.find(params[:tender_id])
    @deal = Deal.new
    @members = @deal.rosters.build
  end

  def create
    @tender = Tender.friendly.find(params[:tender_id])
    @deal = Deal.new(amount: @tender.target, category: "Sale", tender_id: @tender.id)

    if @deal.save
      @deal.rosters.build(rosterable: @tender.tenderable, role: 0)
      flash[:notice] = 'Persetujuan berhasil dibuat'
      redirect_to admin_deal_path(@deal)
    else
      render :index
      Rails.logger.info(@tender.errors.inspect) 
    end    
  end

  def edit
  end

  def update
    if @deal.update(deal_params)
      flash[:notice] = 'Persetujuan berhasil diproses'
      redirect_to admin_deals_path 
    else
      flash[:warning] = 'Persetujuan gagal diproses'
      render :index
    end    
  end

  private

  def set_deal
    @deal = Deal.friendly.find(params[:id])
  end

  # def deal_params
  #   params.require(:deal).permit(
  #     :state, :category, :slug, :aqad, :barcode, :maturity
  #   )
  # end

end