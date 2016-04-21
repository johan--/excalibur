module SimulationsHelper

  def ownership_increase_rate(simulation)
  	number_to_percentage simulation.annual_ownership_increase * 100, precision: 0
  end

  def comparison_to_normal_rent(simulation)
  	result = simulation.mean_rental_spending_annually / simulation.annual_rental
  	number_to_percentage result *100, precision: 1
  end

end