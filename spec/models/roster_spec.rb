require 'rails_helper'

RSpec.describe Roster, :type => :model do
  let!(:biz) { FactoryGirl.create(:business, :with_starter) }
  let!(:member) { FactoryGirl.create(:entrepreneur) }

  before(:each) do
  	@roster = Roster.new(
  			  team: biz.team, rosterable: member, role: 1
  	)
  end

  subject { @roster }

  it { should respond_to(:team) }
  it { should respond_to(:rosterable) }
  it { should respond_to(:role) }
  it { should respond_to(:state) }
  it { should be_valid }

  describe "after save" do
	before(:each) { @roster.save }

	describe "default values set by callback or database" do
	  it "sets state to 'aktif'" do
	    @roster.state.should == 'aktif'
	  end
	end
  end

  describe "scoping roster" do
  	let!(:roster_1) { FactoryGirl.create(:active_manager, :with_user, team: biz.team) }
	let!(:roster_2) { FactoryGirl.create(:pending_member, :with_user, team: biz.team) }

	describe "Roster.members" do
	  let!(:result) { Roster.members }

	  it "returns rosters that are of User class" do
	  	result.count.should == 2
	  end
	end

	describe "Roster.active" do
	  let!(:result) { Roster.active }

	  it "returns rosters that has aktif as a state" do
	  	result.count.should == 1
	  end
	end	
  end

end