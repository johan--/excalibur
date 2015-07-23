require 'rails_helper'

RSpec.describe Team, :type => :model do
  let!(:user) { FactoryGirl.create(:player) }

  describe "business team" do
  	before do
  		@biz = Team.new(type: "Business", name: "Foobar Ltd", 
  						starter_email: user.email)
  	end
  	subject { @biz }

	it { should respond_to(:rosters) }
	it { should respond_to(:users) }
	it { should respond_to(:starter) }

	describe ".starter" do
	  it 'returns the single user that starts the biz team' do
	    result = @biz.starter.full_name
	  
	    result.should == user.full_name
	  end
	end

	describe ".has_as_member?" do
	  before { not_member = FactoryGirl.create(:player)  }
	  
	  it 'returns true if the user is member of the team' do
	    result = @biz.has_as_member?(user)
	  
	    result.should == true
	  end

	  it 'returns false if the user is not member of the team' do
	    result = @biz.has_as_member?(not_member)
	  
	    result.should == false
	  end	  
	end
  end

end
