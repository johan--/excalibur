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
  end

  def new
    @tender = @tenderable.tenders.build
  end

  def edit
  end

  def create
    @tender = @tenderable.tenders.build(tender_params)
    @tender.category = @tenderable.class.name

    respond_to do |format|
      if @tender.save
        format.html { redirect_to user_root_path, notice: 'Proposal berhasil dibuat' }
      else
        format.html do 
          render :new 
          if params[:rosterable_type] && params[:rosterable_id]
            @company = Team.find_by(rosterable_type: params[:rosterable_type], 
                       rosterable_id: params[:rosterable_id])
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @tender.update(tender_params)
        format.html { redirect_to user_root_path, notice: 'Proposal berhasil dikoreksi' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tender.destroy
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Proposal berhasil dihapuskan' }
      format.json { head :no_content }
    end
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
      :category, :target, :target_cents,
      # properties
      :summary, 
      # details
      :aqad, :aqad_code, 
      :intent_type, :intent_assets => []
    )
  end

end
