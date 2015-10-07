class Blog::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :index, :show, :find_posts
  ]
  before_action :blog_layout
  before_action :tag_cloud#, only: [:posts, :show_post, :find_posts]

  def index
    @posts = Post.page(params[:page]).per(7)
    unless current_user.present? && current_user.admin?
      ahoy.track "Visit Blog Root", title: "A guest user visited blog"
    end
  end
  
  def show
    @post = Post.friendly.find(params[:id])
    @root_comments = @post.root_comments
    @comment =  Comment.new
    unless current_user.present? && current_user.admin?
      ahoy.track "Visit a Blog Post", title: "A guest user visited #{@post.title}"
    end
  rescue  
    redirect_to root_path(subdomain: "blog")
  end

  def find_posts
    if params[:topic]
      @posts = Post.by_topic(params[:topic]).page(params[:page]).per(7)
    elsif params[:tag]
      @posts = Post.by_tag(params[:tag]).page(params[:page]).per(7)
    end
  end

private
  def tag_cloud
    @all_posts = Post.all
    @topics = @all_posts.group_by{ |post| post.topic }
  end

end