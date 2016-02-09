require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
  	@user = User.new(email: "galih@example.com", password: "foobarbaz",
  		password_confirmation: "foobarbaz", name: "galih muhammad", 
      understanding: "yes")
  end

  subject { @user }

  it { should respond_to(:comment_threads) }
  it { should respond_to(:identities) }
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

    describe "making comments" do
      before do
        @comment = Comment.new(commentable: @user,  user: admin, 
          body_md: "Hey guys this is my comment!", subject: "assessment" )
        @comment.save
      end

      it "should be able to retrieve the comment belonged to the tender" do
        comments = @user.comment_threads
        expect(comments.count).to eq 1
      end
    end    
    describe ".preferences" do
  	  it 'returns default values of open booelan' do
        expect(@user.open?).to eq true
  	  end

      it 'returns default values of notification booelan' do
        expect(@user.notification?).to eq true
      end

      it 'returns default values of understanding booelan' do
        expect(@user.understanding?).to eq true
      end      
    end

    describe "after create callback" do
      it "has a titleized name attribute" do
      	expect(@user.name).to eq 'galih muhammad'
      end

      it "has a random authentication token" do
      	expect(@user.auth_token).to_not eq nil
      end

      it "has an empy auth with column" do
        expect(@user.auth_with).to eq ''
      end

      it "has a default currency" do
        expect(@user.currency).to eq 'idr'
      end      
    end

    describe "scoping users" do
      let!(:user_3) { FactoryGirl.create(:developer) }
      let!(:user_4) { FactoryGirl.create(:developer) }
      let!(:user_5) { FactoryGirl.create(:fb_user) }
      
      describe "All users which are developers" do
        let!(:result) { User.developers }

        it "returns user that has boolean developer set to true" do
          expect(result.count).to eq 3
        end
      end

      describe "All users which are admin" do
        let!(:result) { User.admins }

        it "returns user that is an admin" do
          expect(result.count).to eq 1
        end
      end

      describe "All users which use omniauth" do
        let!(:result) { User.omniauthers }

        it "returns users that use omniauth" do
          expect(result.count).to eq 1
        end
      end          
    end    
  end

end