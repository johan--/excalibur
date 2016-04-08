require 'rails_helper'

# RSpec.describe Bid, :type => :model do
#   let!(:tender) { FactoryGirl.create(:incomplete_house_purchase_musharaka) }

#   before(:each) do
#   	@bid = FactoryGirl.build(:bid, tender: tender, volume: 800)
#   end

#   subject { @bid }

#   it { should respond_to(:tender) }
#   it { should respond_to(:bidder) }
#   it { should respond_to(:ticker) }
#   it { should respond_to(:price) }
#   it { should respond_to(:volume) }
#   it { should respond_to(:details) }
#   it { should respond_to(:draft) }
#   it { should respond_to(:state) }
#   it { should respond_to(:message) }
#   it { should respond_to(:bid_transitions) }
#   it { should respond_to(:acquisitions) }

#   describe "after save" do
#   	before(:each) { @bid.save }

#   	describe "default values set by callback or database" do
#   	  # it "should sets properties of open to true" do
#   	  # 	expect(@bid.broadcast?).to eq true
#   	  # end

#       it "should sets properties of draft to no if not specified" do
#         expect(@bid.draft?).to eq false
#       end      

#   	  it "should sets default state" do
#   	  	expect(@bid.state).to eq "pending"
#   	  end

#       it "should have price per share at purchase" do
#         expect(@bid.price).to eq tender.price
#       end

#       it "should have ticker" do
#         expect(@bid.ticker).to_not eq nil
#       end
#   	end

#     describe "it should affect the tender associated with the bid" do
#       it "should have 0 shares left" do
#         expect(@bid.tender.shares_left).to eq 0
#       end

#       it "should change its state to closed" do
#         expect(@bid.tender.state).to eq "closed"
#       end

#     end

#     describe "if destroyed" do
#       before(:each) do 
#         @bid.destroy
#       end

#       it "should not really delete the object" do
#         expect(Bid.with_deleted.count).to eq 2
#       end

#       it "should set the volume of the object to 0" do
#         expect(@bid.volume).to eq 0
#       end

#       it "should affect the tender associated with it" do
#         expect(tender.fulfilled?).to eq false
#       end

#       it "should change the tender state" do
#         expect(tender.state).to eq 'open'
#       end      
#     end

#     # describe "if transitioned to confirmed" do
#     #   before { @bid.approving! }

#     #   it "creates an acquisition record" do
#     #     expect(Acquisition.count).to eq 1
#     #   end

#     #   it "also creates a new stock" do
#     #     expect(Stock.last).to eq Acquisition.first.acquireable
#     #   end
#     # end
#   end


# end