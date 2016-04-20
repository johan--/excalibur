class InsidesController < ApplicationController
  respond_to :html, :js
  before_filter :inside_app, except: [:email, 
    :subscribe, :simulation, :change_locale]
  skip_before_action :authenticate_user!, only: [ :email, 
    :subscribe, :simulation, :change_locale ]

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
  def manage_tender
    @tender = Tender.friendly.find(params[:tender_id])
  end

  # def profile
  #   @user = User.friendly.find_by_id(current_user.id)
  # end

  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    
    if @name.blank?
      flash[:alert] = "Tolong isi namamu sebelum mengirimkan pesan. Terima kasih."
      redirect_to root_path
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "Kamu harus menuliskan alamat email yang betul dan valid. Terima kasih."
      redirect_to root_path
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Isi pesanmu kosong. Sedikitnya, pesanmu harus mempunyai 10 karakter."
      redirect_to root_path
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "Kamu tidak bisa mengirim tautan atau link website. Mohon pengertiannya."
      redirect_to root_path
    else    
      ContactMailer.contact_message(@name,@email,@message).deliver_later
      # Contact.create(name: @name, email: @email, message: @message)
      redirect_to root_path, notice: "Pesanmu telah dikirim. Terima kasih."
    end
  end

  def subscribe
    @subscriber = Subscriber.new(email: params[:email], category: params[:category])
    
    if @subscriber.save
      # track! :signup
      # SubscriberMailer.welcome(@subscriber).deliver
      flash[:notice] = "Terima kasih, kami akan kabari kamu"
      redirect_to root_path
      meta_events_tracker.event!(:user, :subscribed, { 
        distinct_id: request.uuid, email: @subscriber.email } 
      )      
    else
      flash.now.alert = "Tolong tulis alamat email yang valid, terima kasih."
      redirect_to root_path
    end    
  end

  def simulation
    @sim = params[:simulation]
    @simulation = MusharakaSimulation.new(maturity: @sim[:maturity], 
        price: @sim[:price], tangible: @sim[:tangible], 
        contribution_percent: @sim[:contribution]
      )
    @results = @simulation.calculation
    meta_events_tracker.event!(:user, :simulate, { 
      price: @sim[:price], capital: @sim[:contribution], 
      period: @sim[:maturity], category: "purchase",
      distinct_id: request.uuid } 
    )
  end

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:user_locale] = l
    redirect_to request.referer || root_url
  end


private
  def subscriber_params
    params.require(:subscriber).permit(
      :email, :category, :from, :origin
    )
  end

end