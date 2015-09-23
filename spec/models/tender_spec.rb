require 'rails_helper'

RSpec.describe Tender, :type => :model do
  let!(:user) { FactoryGirl.create(:client) }
  let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }

  describe "Business Partnership" do
  	before do
  	  @tender = Tender.new(
  	  		category: "Bisnis", aqad: "musharakah",
  			# tenderable: biz, target_sens: 1000000sens
  			tenderable: biz, target: 10000000,
  			summary: "Lorem ipsum dolor cassus")
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
	it { should respond_to(:intent_type) }
	it { should respond_to(:intent_assets) }
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
	  	  @tender.state.should == 'menunggu tawaran'
	  	end	  	
	  end

	  describe ".target" do
		it 'returns the target money sens value of target' do
		  result = @tender.target_sens
		  result.should == 1000000000 #plus two zero digits as sens added
		end
	  end

	  describe "determining access and authorization for a tender" do
	  	describe ".tender_owner?(user)" do
	  	  it "determines whether a user is a tender owner" do
	  	  	result = @tender.tender_owner?(user)
	  	  	result.should == false
	  	  end
	  	end

	  	describe ".tender_owner?(user)" do
	  	  it "determines whether a user is a member of tender creator" do
	  	  	result = @tender.member_of_tenderable?(user)
	  	  	result.should == true
	  	  end
	  	end
	  end

	end
  end

  describe "scoping tender" do
  	let!(:tender_1) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }
  	let!(:tender_2) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }
  	let!(:tender_3) { FactoryGirl.create(:retail, :mudharabah, tenderable: biz) }

  	describe "Tender.open" do
	  let!(:result) { Tender.open }

	  it "returns tender that has open attribute set to true" do
	  	result.count.should == 3
	  end
  	end

  	describe "Tender.with_aqad(aqad)" do
	  let!(:musharakah) { Tender.with_aqad('musharakah') }

	  it "returns tender that has musharakah as aqad" do
	  	musharakah.count.should == 2
	  end
  	end

  end

end