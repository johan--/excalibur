require 'rails_helper'

RSpec.describe Group, :type => :model do

  describe "syndicate (syirkah)" do
  	before { @syndicate = Syndicate.new }

  	subject { @syndicate }

	it { should be_valid }
  	it { should respond_to(:group_memberships) }
  	it { should respond_to(:name) }
  	it { should respond_to(:users) }
  	it { should respond_to(:public) }
  	it { should respond_to(:aqad) }
  	it { should_not respond_to(:tenders) }
  	it { should_not respond_to(:bids) }  	

  	describe "after save" do
  	  let!(:user_1) { FactoryGirl.create(:user) }
  	  let!(:user_2) { FactoryGirl.create(:developer) }

  	  before { @syndicate.save }

  	  describe  "default set to database" do
  	  	it "has the auto set group name" do
  	  	  expect(@syndicate.name).to_not eq nil
  	  	end
  	  end

  	  context "adding valid associated models" do
  	  	before { @syndicate.add(user_1, user_2) }

  	  	it "adds tenders to the group DEAL" do
  	  	  expect(@syndicate.group_memberships.count).to eq 2
  	  	end

  	  	it "makes the tender share the group DEAL" do
  	  	  expect(user_1.shares_any_group?(user_2)).to eq true
  	  	end  	  	
  	  end
  	end
  end

  describe "Deal" do
  	before { @deal = Deal.new }

  	subject { @deal }

	it { should be_valid }
  	it { should respond_to(:group_memberships) }
  	it { should respond_to(:details) }
  	it { should respond_to(:public) }
  	it { should respond_to(:purpose) }
  	it { should_not respond_to(:formal) }
  	it { should_not respond_to(:users) }
  	it { should respond_to(:tenders) }
  	it { should respond_to(:bids) }

  	describe "after save" do
  	  # let!(:user_1) { FactoryGirl.create(:user) }
  	  let!(:tender_1) { FactoryGirl.create(:house_purchase_murabaha) }
  	  let!(:tender_2) { FactoryGirl.create(:house_purchase_musharaka) }

  	  before { @deal.save }

  	  describe  "default set to database" do
  	  	it "has the auto set group name" do
  	  	  expect(@deal.name).to_not eq nil
  	  	end
  	  end

  	  context "adding valid associated models" do
  	  	before { @deal.add(tender_1, tender_2) }

  	  	it "adds tenders to the group DEAL" do
  	  	  expect(@deal.group_memberships.count).to eq 2
  	  	end

  	  	it "makes the tender share the group DEAL" do
  	  	  expect(tender_1.shares_any_group?(tender_2)).to eq true
  	  	end  	  	
  	  end

  	end
  end

end