module LayoutSelector

  def disable_background
    @disable_background = true
  end
  def normal_nav
    @normal_nav = true
  end  
  def blog_layout
    @blog_layout = true
    @recents = Post.recent
  end
  def firm_layout
    @firm_layout = true
  end
  def user_layout
    @user_layout = true
  end
  def admin_layout
    @admin_layout = true
  end

end