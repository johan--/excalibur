module LayoutSelector

  def disable_background
    @disable_background = true
  end
  def blog_layout
    @blog_layout = true
    @recents = Post.recent
  end
  def financier_layout
    @financier_layout = true
    @disable_nav = false
  end
  def user_layout
    @user_layout = true
  end
  def admin_layout
    @admin_layout = true
  end

end