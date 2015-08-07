class Blog::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :index, :show, :find_posts
  ]
  before_action :normal_nav
  before_action :blog_layout
  before_action :tag_cloud#, only: [:posts, :show_post, :find_posts]

  def index
    @posts = Post.page(params[:page]).per(7)
  end
  
  def show
    @post = Post.friendly.find(params[:id])
    @root_comments = @post.root_comments
    @comment =  Comment.new
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