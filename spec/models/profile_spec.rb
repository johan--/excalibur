require 'rails_helper'

RSpec.describe Profile, :type => :model do
	let!(:user) { FactoryGirl.create(:player) }

  describe "user profile" do
		before do 
		  @profile = Profile.new(category: "UserProfile", 
		  						 profileable: user, about: "lorem ipsum dolor")
		end

		subject { @profile }

		it { should respond_to(:category) }
		it { should respond_to(:profileable) }
		it { should respond_to(:about) }
		it { should respond_to(:details) }
		it { should respond_to(:public) }
		it { should respond_to(:last_education) }
		it { should respond_to(:marital_status) }
		it { should respond_to(:work_experience) }
		it { should respond_to(:industry_experience) }
		it { should_not respond_to(:anno) }
		it { should_not respond_to(:founding_size) }
		it { should_not respond_to(:online_presence) }
		it { should_not respond_to(:offline_presence) }

		it { should be_valid }
  end

  describe "biz profile" do
  	let!(:biz) { FactoryGirl.create(:firm, starter_email: user.email) }

		before do 
		  @profile = Profile.new(category: "BizProfile", 
		  						 profileable: biz, about: "lorem ipsum dolor")
		end

		subject { @profile }

		it { should respond_to(:category) }
		it { should respond_to(:profileable) }
		it { should respond_to(:about) }
		it { should respond_to(:details) }
		it { should respond_to(:public) }
		it { should_not respond_to(:last_education) }
		it { should_not respond_to(:marital_status) }
		it { should_not respond_to(:work_experience) }
		it { should_not respond_to(:industry_experience) }
		it { should respond_to(:anno) }
		it { should respond_to(:founding_size) }
		it { should respond_to(:online_presence) }
		it { should respond_to(:offline_presence) }

		it { should be_valid }
  end

end
