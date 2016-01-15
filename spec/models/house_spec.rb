require 'rails_helper'

RSpec.describe House, :type => :model do
  before do
  	@house = FactoryGirl.build(:house)
  end

  subject { @house }

  it { should respond_to(:price) }
  it { should respond_to(:ticker) }
  it { should respond_to(:category) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:avatar) }
  it { should respond_to(:publisher) }
  it { should respond_to(:tenders) }

  it { should be_valid }  	

  describe "when saved" do
  	before(:each) { @house.save }
    
    describe "after create callback" do
      it "has a slug" do
      	expect(@house.slug).to_not eq nil
      end

      it "has set the category" do
      	expect(@house.category).to_not eq nil
      end

      it "has a money object" do
        expect(@house.price_currency).to eq "IDR"
      end

      # it "has a default currency" do
      #   expect(@house.currency).to eq 'idr'
      # end      
    end

    describe "scoping users" do
      # let!(:user_2) { FactoryGirl.create(:admin) }
      # let!(:user_3) { FactoryGirl.create(:developer) }
      # let!(:user_4) { FactoryGirl.create(:developer) }
      
      # describe "All users which are developers" do
      #   let!(:result) { User.developers }

      #   it "returns user that has boolean developer set to true" do
      #     expect(result.count).to eq 3
      #   end
      # end

      # describe "All users which are admin" do
      #   let!(:result) { User.admins }

      #   it "returns user that is an admin" do
      #     expect(result.count).to eq 1
      #   end
      # end      
    end    
  end

end