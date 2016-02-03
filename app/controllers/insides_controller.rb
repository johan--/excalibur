class InsidesController < ApplicationController
  respond_to :html, :js
  before_filter :inside_app

  def home
    @title = "Beranda"
    @tenders = Tender.published
    @bids = Bid.all
  end

  def choose
    @houses = House.includes(:stocks).all
  end

  def lounge
    @users = User.all
  end

  def desk
    @tenders = current_user.tenders
    @bids = current_user.bids
  end

  def marketplace
    @title = "Bursa"
    @tenders = Tender.published
    @fundraisings = @tenders.offering
    @tradings = @tenders.trading
  end

  def profile
    @user = User.friendly.find_by_id(current_user.id)
  end

  def settings
    @settings = Setting.unscoped    
  end

end