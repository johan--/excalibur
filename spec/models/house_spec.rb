require 'rails_helper'

RSpec.describe House, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  describe "empty house" do
    before { @house = FactoryGirl.build(:complete_house, publisher: user) }

    subject { @house }

    it { should respond_to(:price) }
    it { should respond_to(:ticker) }
    it { should respond_to(:category) }
    it { should respond_to(:address) }
    it { should respond_to(:city) }
    it { should respond_to(:avatar) }
    it { should respond_to(:publisher) }
    it { should respond_to(:occupancy) }
    it { should respond_to(:stocks) }

    it { should be_valid }  	

    describe "when saved" do
    	before { @house.save }      
      
      it "has a slug" do
      	expect(@house.slug).to_not eq nil
      end

      it "has a ticker" do
        expect(@house.slug).to_not eq nil
      end

      it "has set the category" do
      	expect(@house.category).to_not eq nil
      end

      it "has a money object" do
        expect(@house.price_currency).to eq "IDR"
      end
    
      it "the user now has one house" do
        expect(user.houses.count).to eq 1
      end

      it "listed the user as the publisher" do
        expect(user.houses.first).to eq @house
      end

      it "has been geocoded" do
        expect(@house.longitude).to_not eq nil
        expect(@house.latitude).to_not eq nil
      end
    
      describe "updating it" do
        before(:each) do
          @house.update(address: 'Margonda Raya', city: 'Depok')
        end

        it "has set new slug" do
          expect(@house.slug).to_not eq nil
        end        
      end
      
    end
  end

  # describe "owned house" do
  #   before { @house = FactoryGirl.create(:owned_house) }
  #   subject { @house }

  #   it { should be_valid }

  #   it "has an occupancy related" do
  #     expect(@house.occupancy).to_not eq nil
  #   end

  #   it "has a stock ownership related" do
  #     expect(@house.stocks.count).to eq 1
  #   end    
  # end

end