class Biz::BaseController < ApplicationController
  before_action :require_operator!
  before_action :set_firm
  before_action :check_subscription, except: [:subscription, :expiration]
  before_action :firm_layout

  def show
  	
  end

  def bookings
  end

  def management
  end

  def settings
  end

  def save_settings
    @dp = @firm.settings(:down_payment).update_attributes!(
      state: firm_pref_params[:dp_state], 
      percentage: firm_pref_params[:dp_percent], 
      deadline: firm_pref_params[:dp_deadline])

    @auto_conf = @firm.settings(:auto_confirmation).update_attributes!(
      state: firm_pref_params[:auto_confirmation_state])
    
    @auto_prom = @firm.settings(:auto_promo).update_attributes!(
      state: firm_pref_params[:auto_promo_state])

    redirect_to biz_root_path
  end 

  def subscribes
    a = @firm.build_subscription(
          category: 1, state: "aktif", start_date: Date.today)
    if a.save
      flash[:notice] = "Berhasil Berlangganan"
    else
      flash[:warning] = "Ada masalah, coba ulangi lagi"
    end
    redirect_to biz_root_path
  end

  def subscription
    @subscription = @firm.subscription
  end

  def expiration

  end

  # def new
  #   @firm = Firm.new
  # end

  def edit
  end


  # def create
  #   @firm = Firm.new(firm_params)

  #   respond_to do |format|
  #     if @firm.save
  #       format.html { redirect_to @firm, notice: 'Firm was successfully created.' }
  #       format.json { render :show, status: :created, location: @firm }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @firm.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @firm.update(firm_params)
        format.html { redirect_to @firm, notice: 'Firm was successfully updated.' }
        format.json { render :show, status: :ok, location: @firm }
      else
        format.html { render :edit }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firm
      @firm = Firm.find(current_user.firm_locator.id) 
      if @firm.nil?
        redirect_to posts_path
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

    def check_subscription
      if @firm.subscription.state != 'aktif'
        redirect_to biz_expiration_path  
      end
    end

end