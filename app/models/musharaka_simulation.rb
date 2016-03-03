class MusharakaSimulation
  include ActiveModel::Model
  include ProfitMargin #capitalization_rate

  attr_accessor :income, :maturity, :price, :contribution_percent, 
  				:tangible

  validates :tangible, presence: true,
  		inclusion: { in: %w(Rumah Apartemen),
	    message: "%{value} is not a valid tangible" }
  
  validates :contribution_percent, presence: true
  validates :maturity, presence: true,
  					   numericality: { only_integer: true }
  validates :price, presence: true, length: {in: 6..12}, 
  					numericality: { only_integer: true }

  def initialize(attributes={})
    super
  	@income = income.to_i
  	@price = price.to_i 
  	@maturity = maturity.to_i
  	@contribution = contribution_percent.to_i * 10
    @par = @price / 1000
    # @avg_acquisition = avg_acquisition.to_i
  end

  def other_party_ownership(contribution)
  	1000 - contribution
  end

  def profit
    "Rp #{monthly_rent}/bulan"
  end


  def avg_acquisition_rate
    other_party_ownership(@contribution) / @maturity
  end

  def acquisition(cost)
    avg_acquisition_rate * cost
  end

  def rental_value(n, contribution)
    lagged_price = geometric_price(n - 1)
    capitalization_rate * lagged_price * other_party_ownership(contribution)
  end

  def geometric_price(n)
    # @par * avg_annual_price_increase**(n)
    @par * (1 - avg_annual_price_increase**(n+1)) / (1-avg_annual_price_increase)
  end

  def calculating_total_spending
    current_ownership = @contribution
    share_spending = 0
    rent_spending = 0
    results = {}
    # current_price = @par

    @maturity.times do |k|
    # until current_ownership == 100  do
      # $i +=1;

      current_price = geometric_price(k) #get the new price after one year

      rent_spending += rental_value(k, current_ownership)
      share_spending += acquisition(current_price)
      current_ownership += avg_acquisition_rate

      results = { obligation: rent_spending, purchase: share_spending, 
        total: rent_spending + share_spending }
    end

    return results
  end

end



