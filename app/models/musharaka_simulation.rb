class MusharakaSimulation
  include ActiveModel::Model

  attr_accessor :maturity, :price, :contribution_percent, :type

  validates :type, presence: true,
  		inclusion: { in: %w(Rumah Apartemen),
	    message: "%{value} is not a valid type" }
  
  validates :contribution_percent, presence: true
  validates :maturity, presence: true,
  					   numericality: { only_integer: true }
  validates :price, presence: true, length: {in: 6..12}, 
  					numericality: { only_integer: true }

  def capitalization_rate
  	if type == 'Rumah'
  		return 7,5
  	elsif type == 'Apartemen'
  		return 8,5
  	end
  end

  def modifier
  	return 0
  end

  def annual_rent
  	price * capitalization_rate + modifier
  end

  def monthly_rent
  	annual_rent / 12
  end

  def other_party_ownership
  	1 - contribution_percent / 100
  end

  def rental_fee
  	monthly_rent * other_party_ownership
  end

  def unit_par_value
  	price /  1000
  end

end