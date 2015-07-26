class Firm < Team
  has_one  :profile, as: :profileable

  def firm_locator  	
  end

end