class Firm::BaseController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :landing
  ]
  before_action :require_financier!, unless: :landing
  # before_action :set_firm
  # before_action :check_subscription, except: [:subscription, :expiration]
  # before_action :firm_layout 
  
  respond_to :html, :js
  
  def landing
    @category = "pendana"
    @disable_nav = true    
  end

  def dashboard
    @tenders = Tender.all
  end

  def subscribes
    # a = @firm.build_subscription(
    #       category: 1, state: "aktif", start_date: Date.today)
    # if a.save
    #   flash[:notice] = "Berhasil berlangganan"
    # else
    #   flash[:warning] = "Ada masalah, coba ulangi lagi"
    # end
    # redirect_to biz_root_path
  end

  def subscription
    @subscription = @firm.subscription
  end

  def expiration
  end

  def edit_bio
  end

  def update_bio
    # @dp = @firm.update_attributes!(
    #   name: firm_params[:name], city: firm_params[:city], 
    #   phone: firm_params[:phone], address: firm_params[:address]
    #   )

    # redirect_to biz_root_path
    # flash[:notice] = 'Akun bisnis berhasil dikoreksi'
  end 

  def profile
  end


  def contact
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

    # def check_subscription
    #   if @firm.subscription.state != 'aktif'
    #     redirect_to biz_expiration_path  
    #   end
    # end

end