class Blog::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :index, :show, :find_posts, :discussion_room
  ]
  before_action :blog_layout
  before_action :tag_cloud#, only: [:posts, :show_post, :find_posts]

  def index
    @index = true
    @posts = Post.page(params[:page]).per(7)
        
    unless current_user.present? && current_user.admin?
      meta_events_tracker.event!(:visit, :blog, { 
        distinct_id: request.uuid }
      )
    end
  end
  
  def show
    @post = Post.friendly.find(params[:id])

    unless current_user.present? && current_user.admin?
      meta_events_tracker.event!(:visit, :blogpost, {
        title: @post.title, topic: @post.topic,
        distinct_id: request.uuid } 
      )
    end
  rescue  
    redirect_to root_path(subdomain: "blog")
  end

  def find_posts
    @index = true
    if params[:topic]
      @posts = Post.by_topic(params[:topic]).page(params[:page]).per(7)
    elsif params[:tag]
      @posts = Post.by_tag(params[:tag]).page(params[:page]).per(7)
    end
  end

  def discussion_room
  end


private
  def tag_cloud
    @all_posts = Post.all
    @topics = @all_posts.group_by{ |post| post.topic }
  end

  def blog_layout
    @blog_layout = true
    @recents = Post.recent
  end

end