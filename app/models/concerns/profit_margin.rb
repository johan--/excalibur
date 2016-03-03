module ProfitMargin
  extend ActiveSupport::Concern
  included do

	  def selling_margin(maturity)
	  	@maturity = maturity.to_i
	  	# @base_margin = Setting['aqad.base_margin']
	  	# @base_year = Setting['aqad.base_year']
	  	@base_margin = 11
	  	@base_year = 5
	  	modifier = 1

	  	if @maturity <= @base_year
	  		return @base_margin * @maturity
	  	else
	  		return (@base_margin + modifier) * @maturity
	  	end  	
	  end

	  def capitalization_rate
		0.10
	  	# @maturity = maturity.to_i
	  	# base_maturity = 5
	  	# if tangible == "Rumah"
	  	# 	# capitalization_rate = Setting['aqad.base_capitalization']
	  	# 	capitalization_rate = 10
	  	# elsif tangible == "Apartemen"
	  	# 	capitalization_rate = 10
	  	# end
	  end

	  def avg_annual_price_increase
	  	# @base_margin = Setting['aqad.base_margin']
	  	0.08
	  end

  end
end