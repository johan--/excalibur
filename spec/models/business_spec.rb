require 'rails_helper'

RSpec.describe Business, :type => :model do
  let!(:user) { FactoryGirl.create(:entrepreneur) }

  before(:each) do
  	@biz = Business.new(name: "ToTo", anno: 2015, starter_email: user.email)
  end

  subject { @biz }

  it { should respond_to(:team) }
  it { should respond_to(:name) }
  it { should respond_to(:profile) }
  it { should respond_to(:open) }
  it { should respond_to(:anno) }
  it { should respond_to(:founding_size) }
  it { should respond_to(:online_presence_types) }
  it { should respond_to(:offline_presence_types) }
  it { should respond_to(:deleted_at) }
  it { should be_valid }

  describe "when saved" do
  	before(:each) { @biz.save }

    it { should respond_to(:rosters) }
    it { should respond_to(:users) }
    
    describe ".profile" do
      let!(:profile)  { @biz.profile }

  	  it 'returns default values of open booelan' do
  	    profile[:open].should == true 
  	  end

  	  it 'returns the value of business anno' do
  	  	profile[:anno].should == 2015
  	  end

  	  it 'returns empty array of online presence types' do
  	  	profile[:online_presence_types].should == []
  	  end
    end

    describe ".team" do
      let!(:team) { @biz.team }

  	  it 'returns the associated team created after save' do  
  	    team.name.should_not == nil 
  	  end

  	  it 'has a category associated with the model' do  
  	    team.category.should == 'Bisnis'
  	  end

  	  it 'has a name associated with the model' do  
  	    team.name.should == "Tim #{@biz.name}"
  	  end

  	  it 'has starter as a roster' do  
  	    team.starter.should == user
  	  end

  	  it '.has_as_member?(user)' do  
  	    team.has_as_member?(user).should == true
  	  end	  
    end

    describe "scoping businesses" do
      let!(:biz_2) { FactoryGirl.create(:business, :with_starter) }
      
      describe "Business.anno(year)" do
        let!(:result) { Business.established_at(2015) }

        it "returns business that was established at 2015" do
          result.count.should == 2
        end
      end

    end      
  end

end