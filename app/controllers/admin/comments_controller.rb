class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [:show, :edit]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new     
    @type = params[:commentable_type]
    @commentable_id = params[:commentable_id]
    @subject = params[:subject]    
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to admin_comments_path
      flash[:notice] = 'Assessment berhasil dibuat'
    else
      render :new
    end 
  end

  def edit
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
