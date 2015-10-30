class MurabahaSimulation
  include ActiveModel::Model

  attr_accessor :maturity, :price, :contribution_percent
  
  validates :maturity, presence: true
  validates :price, presence: true, length: {in: 6..12}, 
  					numericality: { only_integer: true }



  def calc_monthly_installment
  	@price = price.to_i
  	@maturity = maturity.to_i

  	base = 12
  	modifier = 2.5
  	diff_years = @maturity - 5

  	if diff_years <= 0
  		cap_rate = base
  	else
  		cap_rate = (base + diff_years * 2.5)
  	end

  	profit = @price * cap_rate / 100
  	marked_up_price = @price + profit

  	monthly_installment = marked_up_price / @maturity * 12
  end



end