class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :landing, :tos, :email, :subscribe, :upgrade, :simulation, 
    :for_clients, :for_investors, :for_developers, :about_us, 
    :change_locale
  ]
  before_filter :disable_background, only: [
    :tos, :upgrade]

  def landing
    @category = "registration"
    # @current_count = Subscriber.whitelist.count
    @no_layout = true
  end

  def for_clients
    @no_layout = true
  end

  def for_investors
    @no_layout = true
  end

  def for_developers
    @no_layout = true
  end

  def about_us
  end

  def dashboard
    @tenders = Tender.all.order(:created_at).page params[:page]
    @bids = current_user.bids
    @financier_layout = true
  end

  def home
    @documents = current_user.documents
    @tenders = Tender.all

    respond_to do |format| 
      format.html
      format.js
    end
  end

  def tos
  end

  def upgrade
    @no_layout = true
  end

  def contact
  end
  
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
      track! :signup
      # SubscriberMailer.welcome(@subscriber).deliver
      flash[:notice] = "Terima kasih, kami akan kabari kamu"
      redirect_to root_path
    else
      flash.now.alert = "Tolong tulis alamat email yang valid, terima kasih."
      redirect_to root_path
    end    
  end

  def simulation
    if params[:aqad] == 'murabaha'
      @simulation = MurabahaSimulation.new(maturity: params[:maturity], 
        price: params[:price], tangible: params[:tangible], 
        contribution_percent: params[:contribution_percent]
      )
      ahoy.track "Simulated for #{@simulation.tangible}", 
        title: "#{@simulation.maturity} Tahun @ #{@simulation.price}, #{@simulation.contribution_percent}% Modal", 
        category: "Simulation", important: "murabahah"
    elsif params[:aqad] == 'musharaka'
      @simulation = MusharakaSimulation.new(maturity: params[:maturity], 
        price: params[:price], tangible: params[:tangible], 
        contribution_percent: params[:contribution_percent]
      )
      ahoy.track "Simulated for #{@simulation.tangible}", 
        title: "#{@simulation.maturity} Tahun @ #{@simulation.price}, #{@simulation.contribution_percent}% Modal", 
        category: "Simulation", important: "musyarakah"
    end
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