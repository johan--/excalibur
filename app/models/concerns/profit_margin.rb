module ProfitMargin
  extend ActiveSupport::Concern
  included do

	  def selling_margin(maturity)
	  	@maturity = maturity.to_i
	  	base = 27
	  	modifier = 11
	  	diff_years = @maturity - 3

	  	if diff_years == 0
	  		capitalization_rate = base
	  	else
	  		capitalization_rate = base + (diff_years * modifier)
	  	end  	
	  end

	  def capitalization_rate(maturity, tangible)
	  	@maturity = maturity.to_i
	  	base_maturity = 4
	  	diff_maturity = @maturity - 4

	  	if tangible == "Rumah"
	  		base_rate = 5
	  		capitalization_rate = 5
	  	elsif tangible == "Apartemen"
	  		base_rate = 10
	  		capitalization_rate = 8
	  	end
	  end


  end
end