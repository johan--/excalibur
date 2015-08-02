class API::V1::BidsController < API::V1::BaseController
  before_action :set_bid, only: [:show, :update, :destroy]

  def_param_group :bid do
    param :bid, Hash, required: true do
      param :contribution, Integer, "Amount of money that is offered for the tender, in IDR", required: true
      param :bidder_id, Integer, "Id of the bidder as a polymorphic owner", required: true
      param :bidder_type, String, "Type of the bidder, e.g. User, Business, Firm", required: true
      param :tender_id, Integer, "Id of the tender", required: true
    end
  end

  api :GET, "/bids", "Show a bunch of bids"
  description "Show a bunch of bids"
  def index
    @bids = Bid.all
  end

  api :GET, "/bids/:id", "Show attributes of a single bid"
  description "Show a bid for a tender, can be made by individual or group accounts"
  def show
  end

  api :POST, "/bids", "Create a new bid for a specific tender"
  description "Create a new bid with the the bidder"
  param_group :bid
  def create
    @bid = Bid.new(bid_params)
    @bid.bidder = current_user

    if @bid.save
      render json: @bid, status: 201, message: 'Tawaran berhasil dibuat'
    else
      render json: {error: "Tawaran gagal dibuat"}, status: 422
    end
  end

  api :PUT, "/bids/:id", "Update a bid"
  description "Update a bid's attributes"
  param_group :bid
  def update
    if @bid.update(bid_params)
      render json: @bid, status: 200, message: 'Tawaran berhasil diperbaharui'
    else
      render json: {error: 'Tawaran gagal diperbaharui'}, status: 422
    end
  end

  def destroy
    @bid.destroy
    render json: {error: "Tawaran berhasil dihapus"}, status: 422
  end



private
  def set_bid
    @bid = Bid.friendly.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(
      :contribution, :bidder, :tender_id
    )
  end


end