class Trading::TendersController < ApplicationController
  before_filter :inside_app
  skip_before_action :authenticate_user!, only: [ :show ]

  def index
    @tenders = Tender.all
  end

  def show
    set_tender
    unless user_signed_in? && @tender.access_granted?(current_user)
      meta_events_tracker.event!(:visit, :proposal, { proposal_ticker: @tender.ticker, client: @tender.starter_name, referrer: request.referrer } )
    end
  end

  # def discuss
  #   set_tender
    
  #   @comments = @tender.comments
  #   @comment = Comment.new
  #   @type = @tender.class.name
  #   @commentable_id = @tender.id
  #   @subject = "interaction"    
  # end

  def new
    @category = params[:intent]
    @house = House.friendly.find(params[:house_id])
    @tender = Tender.new
  end

  def edit
    set_tender
    @category = @tender.category
    @asset = @tender.tenderable
    @documents = current_user.documents
  end

  def create
    @tender = Tender.new(tender_params)
    if params[:house_id]
      @asset = House.friendly.find(params[:house_id])
    else
      # @asset = Stock.friendly.find(params[:asset_id])
    end
    if params[:tender][:category] == 'fundraising'
      @tender.participate = "yes"
      @tender.aqad = "Musyarakah Mutanaqishah"
      @tender.volume = 1000
      @tender.price = @asset.price / 1000      
    end

    @tender.assign_attributes(starter: current_user, tenderable: @asset)
        
    if @tender.save
      flash[:notice] = 'Proposal berhasil dibuat'
      meta_events_tracker.event!(:user, :created_proposal, { ticker: @tender.ticker, target: @tender.target })
    else
      flash[:danger] = 'Proposal gagal dibuat'
      Rails.logger.info(@tender.errors.inspect) 
    end
    redirect_to user_root_path
  end

  def update
    set_tender
    if @tender.update(tender_params)
      flash[:notice] = 'Proposal berhasil diperbarui'
      redirect_to user_root_path
    else
      render :edit
      flash[:warning] = 'Proposal gagal dikoreksi'
      Rails.logger.info(@tender.errors.inspect) 
    end
  end


private
  def set_tender
    @tender = Tender.friendly.find(params[:id])
    @client = @tender.starter 
    @asset = @tender.tenderable
    @bids = @tender.bids
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