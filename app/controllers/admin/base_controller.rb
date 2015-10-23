class Admin::BaseController < ApplicationController
  before_filter :require_admin!
  before_action :disable_background

  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @last_subscribers = Subscriber.last_subscribes(10)
    @subs_count = Subscriber.count
    @user_count = User.count
    @post_count = Post.count
    @doc_count = Document.count
    @tender_count = Tender.count
  end

  def analytics
    @admin = User.group(:admin).count
  end

  def inbox
  end

  def subscribers
    @subscribers = Subscriber.order(:created_at).page params[:page]
  end

  def whitelisting
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update(name: "whitelisted")
      flash[:notice] = 'Subscriber berhasil di whitelist'
      SubscriberMailer.welcome(@subscriber.email).deliver
    else
      flash[:info] = 'Subscriber gagal di whitelist'
      Rails.logger.info(@subscriber.errors.inspect) 
    end    
    redirect_to admin_subscribers_path
  end

  def send_email
    @file = params[:file] || params[:file_url] || nil
    @from = params[:from]
    @subject = params[:subject]
    @email = params[:email]
    @message = params[:message]

    if @from.blank?
      flash[:alert] = "Tolong isi alamat email kamu. Terima kasih."
    elsif @subject.blank?
      flash[:alert] = "Tolong isi subyek email kamu. Terima kasih."      
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "Kamu harus menuliskan alamat email yang betul dan valid. Terima kasih."
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Isi pesanmu kosong. Sedikitnya, pesanmu harus mempunyai 10 karakter."
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "Kamu tidak bisa mengirim tautan atau link website. Mohon pengertiannya."
    else            
      AdminMailer.admin_outbound(
        @email, @from, @subject, @message, @file).deliver_now
      flash[:notice] =  "Pesanmu telah dikirim. Terima kasih."
    end
    redirect_to admin_root_path
  end

private


end
