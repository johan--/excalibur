require 'rails_helper'

RSpec.describe Bid, :type => :model do
  # let!(:user_2) { FactoryGirl.create(:user) }
  # let!(:tender) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user_2) }

  before(:each) do
  	@bid = FactoryGirl.build(:bid)
  end

  subject { @bid }

  it { should respond_to(:tender) }
  it { should respond_to(:bidder) }

  it { should respond_to(:properties) }
  it { should respond_to(:details) }

  describe "after save" do
  	before(:each) { @bid.save }

  	describe "default values set by callback or database" do
  	  it "should sets properties of open to false" do
  	  	expect(@bid.broadcast?).to eq true
  	  end

  	  it "should sets default state" do
  	  	expect(@bid.state).to eq "pending"
  	  end

      it "should have price per share at purchase" do
        expect(@bid.at_price).to eq @bid.tender.target / 1000
      end

  	  it "should have contribution" do
  	  	expect(@bid.contribution_sens).to eq 30000000000
  	  end

      it "should have barcode" do
        expect(@bid.barcode).to_not eq nil
      end      
  	end
  end


end
