module LayoutSelector
  def inside_app
    @inside = true
  end

  def disable_background
    @disable_background = true
  end
  def user_layout
    @user_layout = true
  end
  def admin_layout
    @admin_layout = true
  end

end