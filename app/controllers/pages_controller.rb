class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [
    :home, :contact
  ]
  before_action :disable_nav, only: :landing
  before_action :normal_nav, only: :posts
  before_action :user_layout, only: [:home, :contact]
  
  def landing
  end

  def home
    @ven_search = Venue.search(search_params)
    @ven_search.sorts = 'name' if @ven_search.sorts.empty?    
    @venues = @ven_search.result
    # @venues = Venue.all.page(params[:page]).per(20)

    respond_to do |format| 
      format.html
      format.js
    end
  end

  def posts
    @posts = Post.published.page(params[:page]).per(10)
  end
  
  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to posts_path
  end

  def contact
  end
  
  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    
    if @name.blank?
      flash[:alert] = "Please enter your name before sending your message. Thank you."
      render :contact
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "You must provide a valid email address before sending your message. Thank you."
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Your message is empty. Requires at least 10 characters. Nothing to send."
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "You can't send links. Thank you for your understanding."
      render :contact
    else    
      ContactMailer.contact_message(@name,@email,@message).deliver_now
      redirect_to root_path, notice: "Your message was sent. Thank you."
    end
  end

end
