# require 'rails_helper'

# RSpec.describe Stock, :type => :model do
#   before { @stock = FactoryGirl.build(:stock) }

#   subject { @stock }

#   it { should respond_to(:price) }
#   it { should respond_to(:volume) }
#   it { should respond_to(:tradeable) }
#   it { should respond_to(:state) }
#   it { should respond_to(:ticker) }
#   it { should respond_to(:category) }
#   it { should respond_to(:initial) }
#   it { should respond_to(:state) }
#   it { should respond_to(:expired) }
#   it { should respond_to(:holder) }
#   it { should respond_to(:house) }

#   it { should be_valid }  	

#   describe "when saved" do
#   	before(:each) { @stock.save }
    
#     describe "before create callback" do
#       it "has a slug" do
#       	expect(@stock.slug).to_not eq nil
#       end

#       it "has set the category" do
#       	expect(@stock.ticker).to_not eq nil
#       end

#       # it "has a money object" do
#       #   expect(@stock.price_currency).to eq "IDR"
#       # end

#     end

#   end

# end