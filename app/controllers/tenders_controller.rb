class TendersController < ApplicationController
  before_action :set_category
  before_action :set_tender, only: [:show, :edit, :update, :destroy]
  before_action :user_layout

  def index
    # @tenders = current_user.tenders.all
  end

  def show
  end

  def new
    @tender = category_class.new
    if params[:team]
      @company = Team.find_by(id: params[:team])
      # @tender
    end
  end

  def edit
    @company = @tender.tenderable
  end

  def create
    @tender = category_class.new(tender_params)
    @tender.category = @category
    @tender.tenderable = current_user if @category == 'ConsumerFinancing'

    respond_to do |format|
      if @tender.save
        format.html { redirect_to user_root_path, notice: 'Pengajuan pembiayaan berhasil dilakukan' }
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

  def category 
    Tender.categories.include?(params[:category]) ? params[:category] : "Tender"
  end

  def category_class 
    category.constantize 
  end

  def set_category
    @category = category 
  end

  def set_tender
    @tender = category_class.find(params[:id])
  end

  def tender_params
    params.require(category.underscore.to_sym).permit(
      :tenderable, :tenderable_type, :tenderable_id, 
      :category, :target, :target_cents,
      :properties => [:aqad, :aqad_code, :summary], 
      :details => [:intent_type, :intent_assets => []]
    )
  end

end
