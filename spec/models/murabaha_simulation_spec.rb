require 'rails_helper'

RSpec.describe MurabahaSimulation, :type => :model do
  	
  	before(:each) do
  	  @year =  8 
	  @price =  500000000
	  @contribution =  30 
  	  @test_class = Struct.new(:maturity) { include ProfitMargin } 
  	  @stub = @test_class.new(@year)
  	  @margin = @stub.selling_margin(@year)
  	  @simulation = MurabahaSimulation.new(
  	  	 maturity: @year, price: @price, tangible: "Rumah", 
         contribution_percent: @contribution)
  	  @first = (@price * @contribution ) / 100
	  @gain = (@price * @margin ) / 100
	  @new_price = (@price ) + @gain
	  @months = @year * 12
	  @mo_installment = (@new_price - @first) / @months
  	end

	subject { @simulation }

	it { should respond_to(:first_payment) }
	it { should respond_to(:installment_left) }
	# it { should respond_to(:maximum_mo_installment) }
	# it { should respond_to(:possible_maturity_term) }
	it { should respond_to(:mark_up) }
	it { should respond_to(:profit) }
	it { should respond_to(:marked_up_price) }
	it { should respond_to(:calc_monthly_installment) }


	describe "calculation process" do
	  	it "sets the first payment correctly" do
	  	  expect(@simulation.first_payment).to eq @first
	  	end

	  	it "sets the markup  correctly" do
	  	  expect(@simulation.mark_up).to eq @margin
	  	end

	  	it "sets the markedup price  correctly" do
	  	  expect(@simulation.marked_up_price).to eq @new_price
	  	end

	  	it "sets the installment_left correctly" do
	  	  expect(@simulation.installment_left).to eq (@new_price - @first)
	  	end

	  	it "calculates monthly installments correctly" do
	  	  expect(@simulation.calc_monthly_installment).to eq (@new_price - @first) / @months
	  	end	  	
	end

end
