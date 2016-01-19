class InsidesController < ApplicationController
  respond_to :html, :js

  def home
    @title = "Beranda"
    @tenders = Tender.all
  end

  def choose
  end

  def marketplace
    @title = "Bursa"
    @tenders = Tender.all
  end

  def profile
    @user = User.friendly.find_by_id(current_user.id)
  end

  def settings
    @settings = Setting.unscoped    
  end

end