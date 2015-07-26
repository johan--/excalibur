module ProfileSti

  def category 
    Profile.categories.include?(params[:category]) ? params[:category] : "Profile"
  end

  def category_class 
    category.constantize 
  end

  def set_category
    @category = category 
  end

	
end