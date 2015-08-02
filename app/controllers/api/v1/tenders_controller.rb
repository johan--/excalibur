class API::V1::TendersController < API::V1::BaseController
  before_action :set_tender, only: [:show, :update, :destroy]
  # before_action :find_tenderable, only: [:index]

  def_param_group :tender do
    param :tender, Hash, required: true do
      param :target, Integer, "Amount of target money that is proposed by the tender, in IDR", required: true
      param :tenderable_id, Integer, "Id of the tenderable as a polymorphic owner", required: true
      param :tenderable_type, String, "Type of the tenderable, e.g. User, Business, Firm", required: true
      param :category, String, "Category of tender, e.g. Bisnis, Konsumsi", required: true
      param :summary, String, "Summary of the proposal, describe in short what the money is for and why people should bid for the tender", required: true
      param :aqad, String, "Type of basic sharia aqad proposed by tenderable, e.g. Musharakah, Murabahah, etc", required: true
      param :intent_type, String, "A classification of intent for the money", required: true
      param :intent_assets, Array, "An array of assets that will be acquired from this proposal", required: true
    end
  end  

  api :GET, "/tenders", "Show a bunch of tenders"
  description "Show a bunch of tenders"
  def index
    @tenders = Tender.all
  end

  api :GET, "/tenders/:id", "Show attributes of a single tender"
  description "Show a tender with also the related bids, can be made by individual or group accounts"
  def show
    @bids = @tender.bids
  end

  api :POST, "/tenders", "Create a new tender"
  description "Create a new tender, by User, Business, Firm"
  param_group :tender
  def create
    @tender = Tender.new(tender_params)

    if @tender.save
      render json: @tender, status: 201, message: 'Proposal berhasil dibuat'
    else
      render json: {error: "Proposal gagal dibuat"}, status: 422
    end
  end

  api :PUT, "/tenders/:id", "Update an existing tender"
  description "Update an existing tender"
  param_group :tender
  def update
    if @tender.update(tender_params)
      render json: @tender, status: 200, message: 'Proposal berhasil diperbaharui'
    else
      render json: {error: 'Proposal gagal diperbaharui'}, status: 422
    end
  end

  def destroy
    @tender.destroy
    render json: {error: "Proposal berhasil dihapus"}, status: 422
  end


private
  def set_tender
    @tender = Tender.friendly.find(params[:id])
  end

  def find_tenderable
    if params[:business_id]
      @tenderable = Business.friendly.find(params[:business_id])
    elsif params[:user_id]
      @tenderable = User.friendly.find(params[:user_id])
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
