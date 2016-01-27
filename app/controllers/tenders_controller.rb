class TendersController < ApplicationController
  before_action :set_tender, only: [
    :show, :edit, :update, :destroy
  ]
  before_action :user_layout

  # def index
  #   @tenders = @starter.tenders
  # end

  def show
    @comments = @tender.comments
    @comment = Comment.new
    @client = @tender.starter 
    @assessment = Comment.assessments.user_as_subject(@client).first
    @type = @tender.class.name
    @commentable_id = @tender.id
    @subject = "interaction"
    @bids = @tender.bids
    @bidders = []

    @bids.each{ |bid| @bidders << bid.bidder }

    # if @tender.aqad == 'murabahah'
    #   @simulation = MurabahaSimulation.new(maturity: @tender.annum, 
    #     price: @tender.target, contribution_percent: @tender.seed_capital )
    # elsif @tender.aqad == 'musyarakah'
    #   @simulation = MusharakaSimulation.new(maturity: @tender.annum, 
    #     price: @tender.target, contribution_percent: @tender.seed_capital,
    #     tangible: @tender.set_tangible_type)
    # end
  end

  def new
    @category = params[:intent]
    @asset_type = params[:asset]
    @asset_id = params[:asset_id]
    @asset = @asset_type.constantize.friendly.find(@asset_id)
    @tender = Tender.new
  end

  def edit
    @category = @tender.category
    @asset = @tender.tenderable
  end

  def create
    @tender = Tender.new(tender_params)
    @tender.starter = current_user
    @tender.tenderable = params[:tender][:asset].constantize.friendly.find(params[:tender][:asset_id])

    if @tender.save
      flash[:notice] = 'Proposal berhasil dibuat'
      redirect_to @tender
    else
      redirect_to user_root_path
      flash[:danger] = 'Proposal gagal dibuat'
      Rails.logger.info(@tender.errors.inspect) 
    end
  end

  def update
    if @tender.update(tender_params)

      flash[:notice] = 'Proposal berhasil dikoreksi'
      redirect_to @tender
    else
      render :edit
      Rails.logger.info(@tender.errors.inspect) 
    end
  end


private
  def set_tender
    @tender = Tender.friendly.find(params[:id])
  end

  def tender_params
    params.require(:tender).permit(
      :asset, :asset_id, :tenderable, :tenderable_type, :tenderable_id, 
      :starter, :starter_type, :starter_id, 
      :category, :price, :price_sens, :volume, :participate,
      :annum, :seed_capital,
      # properties
      :message, :draft,
      # details
      :aqad, :aqad_code
    )
  end

end