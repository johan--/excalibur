module ProfitMargin
  extend ActiveSupport::Concern
  included do

	  def selling_margin(maturity)
	  	@maturity = maturity.to_i
	  	base = 12
	  	modifier = 2.5
	  	diff_years = @maturity - 5

	  	if diff_years <= 0
	  		capitalization_rate = base
	  	else
	  		capitalization_rate = (base + diff_years * 2.5)
	  	end  	
	  end

	  def capitalization_rate(maturity, tangible)
	  	@maturity = maturity.to_i
	  	base_maturity = 4
	  	diff_maturity = @maturity - 4

	  	if tangible == "Rumah"
	  		base_rate = 5
	  		capitalization_rate = 3
	  	elsif tangible == "Apartemen"
	  		base_rate = 10
	  		capitalization_rate = 7
	  	end
	  end


  end
end