require 'rails_helper'

RSpec.describe Tender, :type => :model do
  let!(:user) { FactoryGirl.create(:client) }

  describe "Murabahah financing" do
  	before do
  	  @tender = user.tenders.build(
  	  		category: "User", aqad: "murabahah", use_case: "pembelian",
  			intent: "tempat tinggal", price: 10000000, 
  			tangible: "rumah tunggal", address: "Lorem ipsum dolor cassus")
  	end

	subject { @tender }

	it { should respond_to(:category) }
	it { should respond_to(:tenderable) }
	it { should respond_to(:target) }
	it { should respond_to(:target_sens) }
	it { should respond_to(:properties) }
	it { should respond_to(:open) }
	it { should respond_to(:summary) }
	it { should respond_to(:barcode) }
	it { should respond_to(:details) }
	it { should respond_to(:tangible) }
	it { should respond_to(:intent) }
	it { should respond_to(:use_case) }
	it { should respond_to(:published) }
	it { should respond_to(:aqad) }
	it { should respond_to(:aqad_code) }
	it { should be_valid }

	describe "after save" do
	  before(:each) { @tender.save }

	  describe "default values set by callback or database" do
	  	let!(:properties) { @tender.properties }

	  	it "sets properties of open to true" do
	  	  properties[:open].should == true
	  	end

	  	it "sets barcode" do
	  	  properties[:barcode].should_not == nil
	  	end

	  	it "sets status" do
	  	  @tender.state.should == 'fresh'
	  	end	  	
	  end

	  describe ".target" do
		it 'returns the target money sens value of target' do
		  result = @tender.target_sens
		  result.should == 1000000000 #plus two zero digits as sens added
		end
	  end

	  describe "determining access and authorization for a tender" do
	  	describe ".access_granted?(user)" do
	  	  it "determines whether a user is has permission to alter proposal" do
	  	  	result = @tender.access_granted?(user)
	  	  	result.should == true
	  	  end
	  	end
	  	
	  	describe ".tender_owner?(user)" do
	  	  it "determines whether a user is a tender owner" do
	  	  	result = @tender.tender_owner?(user)
	  	  	result.should == true
	  	  end
	  	end
	  end

	end
  end

  describe "scoping tender" do
  	let!(:tender_1) { FactoryGirl.create(:consumer_tender, :musharakah, tenderable: user) }
  	let!(:tender_2) { FactoryGirl.create(:consumer_tender, :musharakah, tenderable: user) }
  	let!(:tender_3) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user) }

  	describe "Tender.open" do
	  let!(:result) { Tender.open }

	  it "returns tender that has open attribute set to true" do
	  	result.count.should == 3
	  end
  	end

  	describe "Tender.with_aqad(aqad)" do
	  let!(:murabahah) { Tender.with_aqad('murabahah') }

	  it "returns tender that has murabahah as aqad" do
	  	murabahah.count.should == 1
	  end
  	end

  end

end