class MusharakaSimulation
  include ActiveModel::Model

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
  	@contribution = contribution_percent.to_i
  end

  def total_months
  	@maturity * 12
  end

  def first_payment
  	(@contribution  * price / 100)
  end

  def maximum_mo_rental
  	@income * 0.25
  end    

  def capitalization_rate
  	if tangible == "Rumah"
  		capitalization_rate = 7.5
  	elsif tangible == "Apartemen"
  		capitalization_rate = 8.5
  	end
  end

  def modifier
  	modifier = 0
  end

  def annual_rent
  	@price *  capitalization_rate / 100 # + modifier
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

  def unit_par_value
  	@price /  1000
  end

end