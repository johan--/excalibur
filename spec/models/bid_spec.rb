require 'rails_helper'

RSpec.describe Bid, :type => :model do
  # let!(:user) { FactoryGirl.create(:client) }
  # let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }
  # let!(:tender) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }
  # let!(:bidder) { FactoryGirl.create(:investor) }

  # before(:each) do
  # 	@bid = Bid.new(
  # 			  tender: tender, bidder: bidder, contribution: 5000000

  # 		)
  # end

  # subject { @bid }

  # it { should respond_to(:tender) }
  # it { should respond_to(:bidder) }
  # it { should respond_to(:contribution_sens) }
  # it { should respond_to(:properties) }
  # it { should respond_to(:details) }

  # describe "after save" do
  # 	before(:each) { @bid.save }

  # 	describe "default values set by callback or database" do
  # 	  it "should sets properties of open to false" do
  # 	  	@bid.open.should == true
  # 	  end

  # 	  it "should sets default state" do
  # 	  	@bid.state.should == "belum diproses"
  # 	  end

  # 	  it "should have contribution as contribution_sens" do
  # 	  	@bid.contribution_sens.should == 500000000 #plus two zero in the back
  # 	  end  	    	  
  # 	end
  # end


end
