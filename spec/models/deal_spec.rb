require 'rails_helper'

RSpec.describe Deal, :type => :model do
  before(:each) do
  	@tender = FactoryGirl.create(:tender, :murabahah, :completed, :with_tenderable)
  	@deal = FactoryGirl.build(:deal, :trade, tender: @tender)
  end

  subject { @deal }

  it { should respond_to(:term_sheets) }
  it { should respond_to(:teams) }
  it { should respond_to(:rosters) }
  it { should be_valid }

  describe "when saved" do
  	before(:each) { @deal.save }
    
    describe "before create callbacks" do
  	  it 'sets the default state' do
        expect(@deal.state).to eq "draft"
  	  end

  	  it 'sets barcode of not null' do
        expect(@deal.barcode).to_not eq nil
  	  end

  	  it 'sets the aqad of tender' do
        expect(@deal.aqad).to eq @tender.aqad
  	  end

  	  it 'sets the maturity of tender' do
        expect(@deal.maturity).to eq @tender.maturity
  	  end  	  
    end
  end

end