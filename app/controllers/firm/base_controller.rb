class Firm::BaseController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing
  before_action :require_financier!, except: :landing
  # before_filter :set_layout, unless: :landing
  
  # respond_to :html, :js
  
  def landing
    @category = "investor"
    @no_layout = true
  end

  def dashboard
    @tenders = Tender.all.order(:created_at).page params[:page]
    @bids = current_user.bids
    @financier_layout = true
  end


  def edit_bio
  end

  def update_bio
  end 

  def profile
  end


private
  # Only permits admin users
  def require_financier!
    authenticate_user!

    if current_user && !current_user.financier?
      redirect_to root_path
    end
  end

  def set_firm
    @firm = Team.find(current_user.firm_locator.id)
    if @firm.nil?
      redirect_to root_path(subdomain: "blog")
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def firm_params
    params.require(:firm).permit(
      :name, :region, :city, :address, :phone
    )
  end

  def firm_pref_params
    params.require(:firm_pref).permit(
      :dp_state, :dp_percent, :dp_deadline, 
      :auto_confirmation, :auto_confirmation_state,
      :auto_promo, :auto_promo_state
    )
  end
  def set_layout
    @financier_layout = true
  end

end