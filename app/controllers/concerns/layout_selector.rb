module LayoutSelector
  def inside_app
    @inside = true
    @body_class = "mobile-navbar"
  end

  def disable_background
    @disable_background = true
  end
  def user_layout
    @user_layout = true
  end
  def admin_layout
    @admin_layout = true
    @body_class = "hold-transition skin-blue sidebar-mini"
  end

end