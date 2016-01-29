module ProfitMargin
  extend ActiveSupport::Concern
  included do

	  def selling_margin(maturity)
	  	@maturity = maturity.to_i
	  	@base_margin = Setting['aqad.base_margin']
	  	@base_year = Setting['aqad.base_year']
	  	modifier = 1

	  	if @maturity <= @base_year
	  		return @base_margin
	  	else
	  		return (@base_margin + modifier)
	  	end  	
	  end

	  def capitalization_rate(maturity, tangible)
	  	# @maturity = maturity.to_i
	  	# base_maturity = 5

	  	if tangible == "Rumah"
	  		capitalization_rate = Setting['aqad.base_capitalization']
	  	elsif tangible == "Apartemen"
	  		capitalization_rate = Setting['aqad.base_capitalization']
	  	end
	  end


  end
end