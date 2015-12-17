class Admin::TermSheetsController < Admin::BaseController
  before_action :set_term, only: [:edit, :update]
  before_action :set_recipient, only: [:new, :create, :edit, :update]

  # def index
  #   @admin = true
  #   @terms = Deal.order(:created_at).page params[:page]
  # end

  # def show
  # end

  def new
    @deal = Deal.friendly.find(params[:deal_id])
    # @user = User.friendly.find(params[:user_id])
    @term = TermSheet.new
  end

  def create
    @term = TermSheet.new(term_params)
    # @deal = Deal.friendly.find(params[:deal_id])
    # @term.deal = @deal

    if @term.save
      flash[:notice] = 'Kontrak berhasil diajukan'
      redirect_to admin_deal_path(@term.deal)
    else
      render :index
      Rails.logger.info(@tender.errors.inspect) 
    end    
  end

  def edit
  end

  def update
    if @term.update(term_params)
      flash[:notice] = 'Persetujuan berhasil diproses'
      redirect_to admin_terms_path 
    else
      flash[:warning] = 'Persetujuan gagal diproses'
      render :index
    end    
  end

  private

  def find_term
    @term = TermSheet.find(params[:id])
  end

  def set_recipient
    if params[:recipient_type] == 'Business'
      @recipient = Business.friendly.find(params[:recipient_id])
    elsif params[:recipient_type] == 'User'
      @recipient = User.friendly.find(params[:recipient_id])
    # else
    #   find_term
    #   @recipient = @term.recipient
    end    
  end

  def term_params
    params.require(:term_sheet).permit(
      :state, :category, :details, :deal_id, :term_id, 
      :recipient_id, :recipient_type
    )
  end

end