require 'rails_helper'

RSpec.describe Tender, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }

  describe "fundraising for musharaka house purchase" do
	before { @tender = FactoryGirl.create(:fresh_house_purchase_musharaka, starter: user) }

	subject { @tender }

	it { should respond_to(:tenderable) }
	it { should respond_to(:starter) }
	it { should respond_to(:comment_threads) }
	it { should respond_to(:ticker) }
	it { should respond_to(:category) }
	it { should respond_to(:target) }
	it { should respond_to(:price_sens) }
	it { should respond_to(:details) }
	it { should respond_to(:unit) }
	it { should respond_to(:state) }
	it { should respond_to(:draft) }
	it { should respond_to(:aqad) }
	it { should be_valid }

  	it "has the tenderable" do
  	  expect(@tender.tenderable).to_not eq nil
  	end

  	it "sets tender as not a draft" do
  	  expect(@tender.draft?).to eq false
  	end

  	it "sets status" do
  	  expect(@tender.state).to eq 'open'
  	end

	it "automatically create a bid on the behalf of starter" do
	  expect(@tender.bids.count).to eq 1
	end

	it "sets its unit to ownership" do
	  expect(@tender.unit).to eq 'ownership'
	end

	it "sets the price to that of its tenderable" do
	  expect(@tender.price).to eq @tender.tenderable.price / 1000
	end

	it "sets the volume to the max" do
	  expect(@tender.volume).to eq 1000
	end

	  describe "determining access and authorization for a tender" do
	  	describe ".access_granted?(user)" do
	  	  it "determines whether a user is has permission to alter proposal" do
	  	  	result = @tender.access_granted?(user)
	  	  	expect(result).to eq true
	  	  end
	  	end
	  	
	  	describe ".tender_owner?(user)" do
	  	  it "determines whether a user is a tender owner" do
	  	  	result = @tender.tender_owner?(user)
	  	  	expect(result).to eq true
	  	  end
	  	end
	  end	
  end


  # describe "scoping tender" do
  # 	let!(:tender_1) { FactoryGirl.create(:house_purchase_murabaha_tender) }
  # 	let!(:tender_2) { FactoryGirl.create(:house_purchase_musharaka_tender) }
  # 	let!(:tender_3) { FactoryGirl.create(:musharaka_share_sale) }

  # 	describe "Tender.open" do
	 #  let!(:result) { Tender.offering }

	 #  it "returns tender that is fundraising" do
	 #  	expect(result.count).to eq 2
	 #  end
  # 	end

  # 	describe "Tender.with_aqad(aqad)" do
	 #  let!(:result) { Tender.with_aqad('murabaha') }

	 #  it "returns tender that has murabahah as aqad" do
	 #  	expect(result.count).to eq 1
	 #  end
  # 	end
  # end

end