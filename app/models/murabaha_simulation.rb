class MurabahaSimulation
  include ActiveModel::Model
  include ProfitMargin #markup

  attr_accessor :income, :maturity, :price, :contribution_percent, :tangible
  
  validates :maturity, presence: true
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

  def installment_left
  	@price - first_payment
  end

  def maximum_mo_installment
  	@income * 0.4
  end

  def possible_maturity_term
  	installment_left / maximum_mo_installment
  end

  def mark_up
    selling_margin(@maturity)
  end

  def profit
	  profit = @price * mark_up / 100
  end

  def marked_up_price
  	marked_up_price = @price + profit
  end

  def calc_monthly_installment
  	monthly_installment = (marked_up_price - installment_left) / @maturity / 12
  end



end