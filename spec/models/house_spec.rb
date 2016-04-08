require 'rails_helper'

RSpec.describe House, :type => :model do
  describe "empty house" do
    before { @house = FactoryGirl.build(:complete_house) }

    subject { @house }

    it { should respond_to(:price) }
    it { should respond_to(:ticker) }
    it { should respond_to(:category) }
    it { should respond_to(:address) }
    it { should respond_to(:city) }
    it { should respond_to(:avatar) }
    it { should respond_to(:publisher) }
    it { should respond_to(:occupancy) }
    it { should respond_to(:stocks) }

    it { should be_valid }  	

    describe "when saved" do
    	before(:each) { @house.save }
      
      describe "before create callback" do
        it "has a slug" do
        	expect(@house.slug).to_not eq nil
        end

        it "has set the category" do
        	expect(@house.category).to_not eq nil
        end

        it "has a money object" do
          expect(@house.price_currency).to eq "IDR"
        end

      end
      describe "after create callback" do
        before(:each) { @stock = @house.stocks.first }

        it "creates just one stock" do
          expect(@house.stocks.count).to eq 1
        end

        it "creates the stock of ownership" do
          expect(@stock.category).to eq 'ownership'
        end

        it "also set the stock price" do
          expect(@stock.price).to eq @house.price / 1000
        end

        it "also set the stock as the initial stock" do
          expect(@stock.initial).to eq 'yes'
        end

        it "also set the stock as tradeable" do
          expect(@stock.tradeable).to eq true
        end
      end
    end
  end

  describe "owned house" do
    before { @house = FactoryGirl.create(:owned_house) }
    subject { @house }

    it { should be_valid }

    it "has an occupancy related" do
      expect(@house.occupancy).to_not eq nil
    end

    it "has a stock ownership related" do
      expect(@house.stocks.count).to eq 1
    end    
  end

end