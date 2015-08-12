class Blog::CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [
    :new, :edit, :create, :update
  ]
  before_action :set_comment, only: [:edit]

  def new
  	@comment = Comment.new
    @parent = Comment.find(params[:parent_comment])
    @post = @parent.commentable
  end

  def edit
    # @comment = Comment.friendly.find(params[:id])
    @post = Post.friendly.find(params[:post_id])
  end

  def create
	  @comment = Comment.new(comment_params)
	  @comment.user = current_or_guest_user
    @post = Post.friendly.find(params[:post_id])
    @comment.commentable = @post

    if @comment.save
      ahoy.track "Posting Comment", title: "#{@comment.user} posted blog comments"
      redirect_to blog_post_path(@post)
      flash[:notice] = 'Komentar berhasil dibuat'
    else
      render :new
    end	
  end

  def update
    @post = Post.friendly.find(params[:post_id])
    @comment = Comment.friendly.find(params[:id])

    if @comment.update(comment_params)
      ahoy.track "Updating Comment", title: "Comment no.#{@comment.id} was edited"
      redirect_to blog_post_path(@post)
      flash[:notice] =  'Komentar berhasil dikoreksi'
    else
      render :edit
    end  	
  end


private
  def set_comment
  	@comment = Comment.friendly.find(params[:id])
  end

  def comment_params
  	params.require(:comment).permit(
  	  :commentable, :commentable_id, :commentable_type, 
      :title, :body, :subject, :parent_id
  	)
  end	

end