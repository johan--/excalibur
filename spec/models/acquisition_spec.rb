require 'rails_helper'

RSpec.describe Acquisition, :type => :model do
  let!(:tender) { FactoryGirl.create(:incomplete_house_purchase_musharaka) }

  before do
  	tender.bids.first.approving!
  	@acquisition = Acquisition.first
  end

  subject { @acquisition }

  it { should respond_to(:benefactor) }
  it { should respond_to(:bid) }
  it { should respond_to(:acquireable) }
  it { should respond_to(:details) }

  describe "the after effect" do
    it "creates an acquisition record" do
      expect(Acquisition.count).to eq 2 #stock acquisition and occupancy transfer
    end

    it "also connects to the related bid correctly" do
      expect(@acquisition.bid).to eq tender.bids.first
    end

    describe "about the stock" do
      before { @stock = Stock.last }

	  it "also creates a new stock" do
	    expect(@stock).to eq @acquisition.acquireable
	  end

	  it "should be related to the bidder" do
	    expect(@stock.holder).to eq @acquisition.bid.bidder
	  end

	  it "should also mention the right volume" do
	    expect(@stock.volume).to eq tender.bids.first.volume
	  end

	  it "should also mention the right price" do
	    expect(@stock.price).to eq tender.price
	  end

	  it "should also mention the stock parent" do
	    expect(@stock.parent).to eq tender.tenderable
	  end
    end
  end

end
