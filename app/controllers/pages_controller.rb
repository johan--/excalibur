class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :landing, :posts, :show_post, :email # :home, :contact 
  ]
  before_action :disable_nav, only: :landing
  before_action :normal_nav, only: [:posts, :show_post]
  before_action :blog_layout, only: [:posts, :show_post]
  before_action :tag_cloud, only: [:posts, :show_post]
  before_action :user_layout, only: [:home, :contact]

  def landing
  end

  def home
    @businesses = current_user.businesses

    respond_to do |format| 
      format.html
      format.js
    end
  end

  def posts
    @posts = Post.page(params[:page]).per(7)
  end
  
  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to root_path(subdomain: "blog")
  end

  def find_posts
    @posts = Post.by_topic(params[:topic])
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

private
  def tag_cloud
    @posts = Post.all
    @topics = @posts.group_by{ |post| post.topic }
    # @tags = Post.tag_counts_on(:tags)
  end


end
