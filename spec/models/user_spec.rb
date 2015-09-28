require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) do
  	@user = User.new(email: "galih@example.com", password: "foobarbaz",
  		password_confirmation: "foobarbaz", name: "galih muhammad", client: true)
  end

  subject { @user }

  it { should respond_to(:profile) }
  it { should respond_to(:preferences) }
  it { should respond_to(:open) }
  it { should respond_to(:about) }
  it { should respond_to(:last_education) }
  it { should respond_to(:marital_status) }
  it { should respond_to(:work_experience) }
  it { should respond_to(:occupation) }
  it { should respond_to(:number_dependents) }
  it { should respond_to(:monthly_income) }
  it { should respond_to(:monthly_expense) }
  it { should respond_to(:avatar) }
  it { should respond_to(:auth_token) }

  it { should be_valid }  	

  describe "when saved" do
  	before(:each) { @user.save }
    
    describe ".profile" do
      let!(:profile)  { @user.profile }

  	  it 'returns default values of open booelan' do
  	    profile[:open].should == true 
  	  end

  	  it 'returns default value of client boolean' do
  	  	profile[:client].should == true 
  	  end

  	  it 'returns default value of financier boolean' do
  	  	profile[:financier].should == nil
  	  end
    end

    describe "after create callback" do
      it "has a titleized name attribute" do
      	@user.name.should == 'Galih Muhammad'
      end

      it "has a random authentication token" do
      	@user.auth_token.should_not == nil
      end

      it "has a default language" do
        @user.language.should == 'bahasa'
      end

      it "has a default currency" do
        @user.currency.should == 'idr'
      end      
    end

    describe "scoping users" do
      let!(:user_2) { FactoryGirl.create(:client) }
      let!(:user_3) { FactoryGirl.create(:client) }
      let!(:user_4) { FactoryGirl.create(:financier) }
      
      describe "All users which are clients" do
        let!(:result) { User.clients }

        it "returns user that has boolean client set to true" do
          result.count.should == 3
        end
      end

      describe "All users which are financiers" do
        let!(:result) { User.financiers }

        it "returns user that has financier client set to true" do
          result.count.should == 1
        end
      end      
    end    
  end

end