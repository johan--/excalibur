class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit]

  def new
    @comment = Comment.new 
    # respond_to :js    
  end

  def create
	  @comment = Comment.new(comment_params)

    if @comment.save
      # ahoy.track "Posting Comment", title: "#{@comment.user} commented on #{@comment.commentable.class.name}"
      flash[:notice] = 'Komentar berhasil dibuat'
    else
      flash[:warning] = 'Komentar gagal dibuat'
    end 
      redirect_to :back
  end

  def edit
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to :back
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
      :title, :body_md, :body_html, :subject, :parent_id, :user_id
  	)
  end	

end