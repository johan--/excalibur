class InvestorReturn
  include ActiveModel::Model
  include ProfitMargin #capitalization_rate

  attr_accessor :maturity, :volume, :asset_price


  def initialize(attributes={})
    super
  	@volume = volume.to_i
  	@price = asset_price.to_i 
  	@maturity = maturity.to_i
  end

  def total_months
  	@maturity * 12
  end

  def annual
  	(@contribution  * price / 100)
  end

  def maximum_mo_rental
  	@income * 0.25
  end    

  def modifier
  	modifier = 0
  end

  def rate
    capitalization_rate(@maturity, tangible)
  end

  def annual_rent
  	@price *  rate / 100 # + modifier
  end

  def monthly_rent
  	annual_rent / 12
  end

  def other_party_ownership
  	(100 - @contribution)
  end

  def rental_fee
  	monthly_rent * other_party_ownership / 100
  end

  def profit
    "Rp #{monthly_rent}/bulan"
  end

  def unit_par_value
  	@price /  1000
  end

end