class Trading::BidsController < ApplicationController
  before_action :set_bid, only: [:edit, :update, :destroy, :finalize]
  before_action :find_tender
  before_action :user_layout

  # def show
  # end

  def new
    @bid = @tender.bids.build
  end

  def edit
  end

  def create
    @bid = @tender.bids.build()
    @bid.assign_attributes(bidder: current_user, volume: params[:volume], tender: @tender)

    if @bid.save
      redirect_to @tender, notice: 'Tawaran berhasil diajukan'
    else
      render :new
    end
  end

  def update
    if @bid.update(bid_params)
      redirect_to @tender, notice: 'Tawaran berhasil dikoreksi'
    else
      render :edit
    end
  end

  def destroy
    @bid.destroy
    redirect_to @tender, notice: 'Tawaran berhasil ditarik'
  end

  def finalize
    # @bid.transitioning!
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
      :volume, :message, :tender_id
    )
  end


end