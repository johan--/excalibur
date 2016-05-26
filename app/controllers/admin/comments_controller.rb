class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [:edit, :destroy]

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.assign_attributes(user_id: current_user.id)

    if @comment.save
      flash[:notice] = 'Assessment berhasil dibuat'
    else
      flash[:warning] = 'Assessment gagal dibuat'
    end
    redirect_to :back
  end

  def edit
    @type = @comment.commentable.class.name
    @commentable_id = @comment.commentable.id
    @subject = @comment.subject
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to admin_comments_path
      flash[:notice] =  'Komentar berhasil dikoreksi'
    else
      render :edit
    end   
  end

  def destroy
    @comment.delete
    flash[:notice] =  'Komentar berhasil dihapus'
    redirect_to admin_comments_path
  end

private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :commentable, :commentable_id, :commentable_type, 
      :title, :body_md, :body_html, :subject, :parent_id, :user_id      
    )
  end

end
