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

private


end
