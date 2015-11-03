class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :landing, :tos, :email, :subscribe, :upgrade, :simulation
  ]
  before_filter :disable_background, only: [:tos, :upgrade]

  def landing
    # @category = "registration"
    # @current_count = Subscriber.whitelist.count
    @no_layout = true
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
        price: params[:price], contribution_percent: params[:contribution_percent] )
    elsif params[:aqad] == 'musharaka'
      @simulation = MusharakaSimulation.new(maturity: params[:maturity], 
        price: params[:price], contribution_percent: params[:contribution_percent],
        tangible: params[:tangible] )
    end
  end


private
  def subscriber_params
    params.require(:subscriber).permit(
      :email, :category, :from, :origin
    )
  end

end