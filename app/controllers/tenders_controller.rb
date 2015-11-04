class TendersController < ApplicationController
  before_action :set_tender, only: [
    :edit, :update, :destroy
  ]
  before_action :find_tender, only: :show
  before_action :find_tenderable
  before_action :user_layout

  def index
    @tenders = @tenderable.tenders
  end

  def show
    @bids = @tender.bids
    if @tender.aqad == 'murabahah'
      @simulation = MurabahaSimulation.new(maturity: @tender.maturity, 
        price: @tender.target, contribution_percent: @tender.own_capital )
    elsif @tender.aqad == 'musyarakah'
      @simulation = MusharakaSimulation.new(maturity: @tender.maturity, 
        price: @tender.target, contribution_percent: @tender.own_capital,
        tangible: @tender.set_tangible_type)
    end

    unless current_user == @tenderable
      ahoy.track "Viewed proposal", 
        title: "made by#{@tenderable.name}: #{@tender.barcode} |#{@tender.category.upcase}|", 
        category: "Tender", important: "#{@tender.aqad}"
    end
  end

  def new
    @aqad = params[:aqad]
    @tender = @tenderable.tenders.build
  end

  def edit
    @aqad = @tender.aqad
  end

  def create
    @tender = @tenderable.tenders.build(tender_params)
    @tender.category = @tenderable.class.name

    if @tender.save
      ahoy.track "Created #{@tender.aqad} proposal", 
        title: "#{@tenderable.name}: #{@tender.barcode} |#{@tender.category.upcase}|", 
        category: "Tender", important: "#{@tender.aqad}"
      flash[:notice] = 'Proposal berhasil dibuat'
      redirect_to @tender
    else
      render :new 
      find_tenderable
      Rails.logger.info(@tender.errors.inspect) 
    end
  end

  def update
    if @tender.update(tender_params)
      ahoy.track "Edited #{@tender.aqad} proposal", 
        title: "#{@tenderable.name}: #{@tender.barcode} |#{@tender.category.upcase}|",
        category: "Tender", important: "#{@tender.aqad}"
      flash[:notice] = 'Proposal berhasil dikoreksi'
      redirect_to @tender
    else
      render :edit
      Rails.logger.info(@tender.errors.inspect) 
    end
  end

  def destroy
    @tender.destroy
    flash[:notice] = 'Proposal berhasil dihapuskan'
    redirect_to user_root_path
  end


private
  def find_tender
    @tender = Tender.friendly.find(params[:id])
  end

  def set_tender
    find_tenderable
    @tender = @tenderable.tenders.friendly.find(params[:id])
  end

  def find_tenderable
    if params[:business_id]
      @tenderable = Business.friendly.find(params[:business_id])
    elsif params[:user_id]
      @tenderable = User.friendly.find(params[:user_id])
    else
      find_tender
      @tenderable = @tender.tenderable
    end
  end

  def tender_params
    params.require(:tender).permit(
      :tenderable, :tenderable_type, :tenderable_id, 
      :category, :target, :target_sens,
      # properties
      :summary, :published,
      # details
      :aqad, :aqad_code, :use_case,
      :intent, :tangible, :address, :price, :maturity, :own_capital
    )
  end

end