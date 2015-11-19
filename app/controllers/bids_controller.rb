class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :finalize]
  before_action :find_tender
  before_action :user_layout

  def show
  end

  def new
    @bid = @tender.bids.build
  end

  def edit
  end

  def create
    @bid = @tender.bids.build(bid_params)
    @bid.bidder = current_user

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @tender, notice: 'Tawaran berhasil diajukan' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @tender, notice: 'Tawaran berhasil dikoreksi' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to firm_dashboard_url(subdomain: ''), notice: 'Tawaran berhasil ditarik' }
      format.json { head :no_content }
    end
  end

  def finalize
    @bid.transitioning!
  end

private
  def find_tender
    @tender = Tender.friendly.find(params[:tender_id])
  end

  def set_bid
    find_tender
    @bid = @tender.bids.friendly.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(
      :contribution, :summary, :shares
    )
  end


end