class Admin::PostsController < Admin::BaseController

  before_action :set_post, only: [
    :show,
    :edit,
    :update,
    :destroy, :remove_header
  ]


  def index
    @published_post_count = Post.published.count
    @draft_post_count = Post.drafted.count
    @posts = Post.published.page(params[:page]).per(50)
  end

  def show
  end

  def drafts
    @posts = Post.drafted.page(params[:page]).per(50)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save 
      redirect_to admin_posts_path, notice: "New post published."
    else
      flash[:alert] = "Post not published."
      render :new
    end
  end

  def edit
  end

  def update
    # @post.slug = nil
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post successfully edited."
    else
      flash[:alert] = "The post was not edited."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "The post has been deleted."
  end

  def remove_header
    if Cloudinary::Uploader.destroy(@post.header, type: :upload)
      @post.update_column(:header, nil)
      flash[:notice] = 'Header berhasil dihapuskan'
    else
      flash[:warning] = 'Header gagal dihapuskan'
    end
    redirect_to admin_posts_path
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
    :title,
    :content_md,
    :header,
    :delete_image,
    :meta_description,
    :meta_image,
    :image_id,
    :topic,
    :tags_text,
    :draft,
    :updated_at
    )
  end


end
