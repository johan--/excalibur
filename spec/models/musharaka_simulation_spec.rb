require 'rails_helper'

RSpec.describe MusharakaSimulation, :type => :model do
  	
  	before(:each) do
  	  @year =  8 
	  @price =  500
	  @denom = 1000000
	  @contribution =  30 
	  @tangible = "Rumah"
  	  @test_class = Struct.new(:maturity) { include ProfitMargin } 
  	  @stub = @test_class.new(@year)
  	  @margin = @stub.capitalization_rate(@year, @tangible)

  	  @simulation = MusharakaSimulation.new(
  	  	 maturity: @year, price: @price, tangible: @tangible, 
         contribution_percent: @contribution)

  	  @first = (@price * @contribution * @denom) / 100
	  @annual_rent = (@price * @margin * @denom) / 100
	  @monthly_rent = @annual_rent / 12
	  @months = @year * 12
	  @other_ownership = 100 - @contribution
	  @rental = (@monthly_rent * @other_ownership) / 100
  	end

	subject { @simulation }

	it { should respond_to(:first_payment) }
	it { should respond_to(:rate) }
	it { should respond_to(:annual_rent) }
	it { should respond_to(:monthly_rent) }
	it { should respond_to(:other_party_ownership) }
	it { should respond_to(:rental_fee) }


	describe "calculation process" do
	  	it "sets the first payment correctly" do
	  	  expect(@simulation.first_payment).to eq @first
	  	end

	  	it "sets the rate correctly" do
	  	  expect(@simulation.rate).to eq @margin
	  	end

	  	it "sets the monthly rent correctly" do
	  	  expect(@simulation.monthly_rent).to eq @monthly_rent
	  	end

	  	it "sets the rental fee correctly for client" do
	  	  expect(@simulation.rental_fee).to eq @rental
	  	end

	  	# it "calculates monthly installments correctly" do
	  	#   expect(@simulation.calc_monthly_installment).to eq (@new_price - @first) / @months
	  	# end	  	
	end

end
