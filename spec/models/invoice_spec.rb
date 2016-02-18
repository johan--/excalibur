require 'rails_helper'

RSpec.describe Invoice, :type => :model do
  let!(:bid) { FactoryGirl.create(:bid, :for_purchase_musharaka) }
  let!(:value) { bid.price * bid.volume }

  before(:each) do
  	@invoice = Invoice.create(invoiceable: bid, amount: value, recipient: bid.bidder,
  		category: "funding", deadline: 7.days.from_now)
  end

  subject { @invoice }

  it { should be_valid }

  it "should generate a ticker code" do
  	expect(@invoice.ticker).to_not eq nil
  end
  it "should generate a default state" do
  	expect(@invoice.state).to_not eq nil
  end

  describe "when gets paid fully" do
  	before do
  	  @pay = @invoice.payments.create(sender: bid.bidder, amount: value)
  	end

  	it "should transition the invoice to complete" do
  	  expect(@invoice.state).to eq 'complete'
  	end
  end


  describe "when gets paid half or not full" do
  	before do
  	  @pay = @invoice.payments.create(sender: bid.bidder, amount: value * 2)
  	end

  	it "should not be valid" do
  	  expect(@pay).to_not be_valid
  	end

  	it "should not transition the invoice to complete" do
  	  expect(@invoice.state).to eq 'active'
  	end
  end

end