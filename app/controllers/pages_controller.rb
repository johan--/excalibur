class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_filter :disable_background

  def landing
    @category = "registration"
    @no_layout = true


    unless current_user.present?
      meta_events_tracker.event!(:visit, :landing, { 
        distinct_id: request.uuid }
      )
    end    
  end

  def about_us
    @static = true
  end

  def ownership
    @static = true
    @category = "ownership"
  end

  def funding
    @static = true
    @category = "funding"
  end

  def open_simulation
    @for = params[:type]
    @aqad = params[:aqad]
    # meta_events_tracker.event!(:user, :open_simulation, { type: @for } )
  end

  def tos
  end

  def upgrade
    @static = true
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


  def prepare_request
  end

  def send_request
    @soft_request = SoftRequest.build_from(
      params[:name], params[:email], params[:occupation], 
      params[:income], params[:tangible], params[:address], 
      params[:price], params[:capital])

    if @soft_request.valid?
      ContactMailer.funding_request_message(
        params[:name], params[:email], @soft_request.message).deliver_later
      flash.now.notice = "Terima kasih, permintaanmu sudah dikirimkan."
    else
      flash.now.alert = "Maaf ada masalah, mohon coba lagi."
    end
  end

  def simulation
    @sim = params[:simulation]
    if @sim[:aqad] == 'murabaha'
      @simulation = MurabahaSimulation.new(maturity: @sim[:maturity], 
        price: @sim[:price], tangible: @sim[:tangible], 
        contribution_percent: @sim[:contribution]
      )
    elsif @sim[:aqad] == 'musharaka'
      @simulation = MusharakaSimulation.new(maturity: 10, 
        price: @sim[:price], tangible: @sim[:tangible], 
        contribution_percent: @sim[:contribution]
      )
    end
    meta_events_tracker.event!(:user, :simulate, { 
      aqad: @sim[:aqad], capital: @sim[:contribution], 
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