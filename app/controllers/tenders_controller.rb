class TendersController < ApplicationController
  before_filter :inside_app

  def index
    @title = "Bursa"
    @tenders = Tender.published
  end

  def show
    set_tender
    @assessment = Comment.assessments.user_as_subject(@client).first
    @comments = @tender.comments
    @comment = Comment.new
    @type = @tender.class.name
    @commentable_id = @tender.id
    @subject = "interaction"        
  end

  def discuss
    set_tender
    
    @comments = @tender.comments
    @comment = Comment.new
    @type = @tender.class.name
    @commentable_id = @tender.id
    @subject = "interaction"    
  end

  def new
    @houses = House.all
    @stocks = Stock.all
    # @category = params[:intent]
    # @aqad = params[:akad]
    # @asset_type = params[:asset]
    # @asset_id = params[:asset_id]
    # @asset = @asset_type.constantize.friendly.find(@asset_id)
    @tender = Tender.new
  end

  def edit
    set_tender
    @category = @tender.category
    @asset = @tender.tenderable
  end

  def create
    if params[:house_id]
      @house = House.friendly.find(params[:house_id])
      @tender = Tender.create(starter: current_user, 
        tenderable: @house.stocks.initial, draft: 'yes', 
        category: "fundraising", annum: 10, 
        aqad: "Musyarakah Mutanaqishah")
    else
      @tender = Tender.new(tender_params)
      @tender.starter = current_user
      @tender.tenderable = @house.stocks.initial
      tender.save
    end
        
    if @tender.valid?
      flash[:notice] = 'Proposal berhasil dibuat'
      # redirect_to tender_build_path(@tender, Tender.builds.first)
      redirect_to user_root_path
    else
      redirect_to new_tender_path
      flash[:danger] = 'Proposal gagal dibuat'
      Rails.logger.info(@tender.errors.inspect) 
    end
  end

  def update
    set_tender
    if @tender.update(tender_params)

      flash[:notice] = 'Proposal berhasil dikoreksi'
      redirect_to user_root_path
    else
      render :edit
      Rails.logger.info(@tender.errors.inspect) 
    end
  end


private
  def set_tender
    @tender = Tender.includes(:bids).friendly.find(params[:id])
    @client = @tender.starter 
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