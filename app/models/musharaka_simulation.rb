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
    @ownership =  contribution_percent.to_i / Float(100)
  	@shares = contribution_percent.to_i * 10
    @par = @price / 1000
    # @avg_acquisition = avg_acquisition.to_i
  end

  def initial_outlay
    @par * @shares
  end

  def other_party_shares(contribution)
  	1000 - contribution
  end

  def share_purchased
    "#{@shares} dari 1000"
  end

  def profit
    "Rp #{monthly_rent}/bulan"
  end

  def annual_rental
    capitalization_rate(tangible) * @price
  end

  def annual_share_purchase
    other_party_shares(@shares) / @maturity
  end

  def annual_ownership_increase
    left = 1 - @ownership
    left / @maturity
  end

  def acquisition(cost)
    annual_share_purchase * cost
  end

  def calculation
    current_ownership = @ownership
    share_spending = 0
    rent_spending = 0
    results = {}

    @maturity.times do |k| # until current_ownership == 100 
      current_price = geometric_price(k) #get the new price after each year

      rent_spending += rental_payment(current_ownership).round(0)
      share_spending += acquisition(current_price).round(0)
      current_ownership += annual_ownership_increase
      tot = rent_spending + share_spending

      results = { 
        obligation: rent_spending, purchase: share_spending, 
        total: tot }
    end

    return results
  end

  def mean_rental_spending_annually
    self.calculation[:obligation] / @maturity
  end

  def mean_acquisition_annually
    self.calculation[:purchase] / @maturity
  end

  def mean_acquisition_monthly
    mean_acquisition_annually / 12
  end

  def monthly_average_of_total(number)
    number / (@maturity * 12)
  end

  def geometric_price(n)
    power = n - 1
    @par * avg_annual_price_increase**power
  end

  def rental_payment(ownership)
    annual_rental * (1 - ownership) 
  end

end