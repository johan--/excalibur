require 'rails_helper'

# RSpec.describe Acquisition, :type => :model do
#   let!(:tender) { FactoryGirl.create(:incomplete_house_purchase_musharaka) }
#   let!(:bid) { tender.bids.first }

#   before do
#     tender.transition_to!(:running)
#     # @pay = bid.invoice.payments.create(sender: bid.bidder, amount: bid.contribution)
#     # @pay.confirm_payment! # equal to bid.approving!, transition the payment, then invoice, then the bid state machine
#     @pay = FactoryGirl.create(:full_payment, invoice: bid.invoice)
#   	@acquisition = Acquisition.first
#   end

#   subject { @acquisition }

#   it { should respond_to(:benefactor) }
#   it { should respond_to(:bid) }
#   it { should respond_to(:acquireable) }
#   it { should respond_to(:details) }

#   describe "the after effect of bid by client" do
#     it "creates an acquisition record" do
#       expect(Acquisition.count).to eq 2 #stock acquisition and occupancy transfer
#     end

#     it "also connects to the related bid correctly" do
#       expect(@acquisition.bid).to eq bid
#     end

#     describe "about the stock" do
#       before { @stock = Stock.last }

#   	  it "also creates a new stock" do
#   	    expect(@stock).to eq @acquisition.acquireable
#   	  end

#   	  it "should be related to the bidder" do
#   	    expect(@stock.holder).to eq @acquisition.bid.bidder
#   	  end

#   	  it "should also mention the right volume" do
#   	    expect(@stock.volume).to eq bid.volume
#   	  end

#   	  it "should also mention the right price" do
#   	    expect(@stock.price).to eq tender.price
#   	  end

#   	  it "should also mention the stock parent" do
#   	    expect(@stock.parent).to eq tender.tenderable
#   	  end
#     end

#     describe "about the occupancy" do
#       before { @occupancy = Occupancy.first }

#       it "the occupancy should have the client as the holder" do
#       	expect(@occupancy.holder).to eq bid.bidder
#       end

#       it "the occupancy should have the house as the holder" do
#       	expect(@occupancy.house).to eq tender.tenderable.house
#       end      
#     end
#   end

# end