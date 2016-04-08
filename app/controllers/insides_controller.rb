class InsidesController < ApplicationController
  respond_to :html, :js
  before_filter :inside_app

  def home
    @title = "Beranda"
    @tenders = current_user.tenders.offering
    @tender = @tenders.first
    @bids = current_user.bids
    @documents = current_user.documents
    @houses = current_user.houses
    @houses_count = @houses.count 
    @tender_count = @tenders.count
    @bids_count = @bids.count

    if params[:not_done] == 'true'
      flash[:warning] = 'Data belum lengkap, mohon lanjutkan' 
    end
  end

  def choose
    @houses = House.includes(:stocks).all
  end

  def starting
  end

  def manage_tender
    @tender = Tender.friendly.find(params[:tender_id])
  end

  # def marketplace
  #   @title = "Bursa"
  #   @tenders = Tender.published
  #   @fundraisings = @tenders.offering
  #   @tradings = @tenders.trading
  # end

  def profile
    @user = User.friendly.find_by_id(current_user.id)
  end

  def settings
    @settings = Setting.unscoped    
  end

end