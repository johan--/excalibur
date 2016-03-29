class InsidesController < ApplicationController
  respond_to :html, :js
  before_filter :inside_app

  def home
    @title = "Beranda"
    @tender = current_user.tenders.offering.first
    @bids = current_user.bids
    @documents = current_user.documents
    @groups = @documents.group_by { |doc| doc.category }    
  end

  def choose
    @houses = House.includes(:stocks).all
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