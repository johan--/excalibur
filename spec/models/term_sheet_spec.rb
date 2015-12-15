require 'rails_helper'

RSpec.describe TermSheet, :type => :model do
  before(:each) do
  	@deal = FactoryGirl.create(:consumer_deal, :with_tender)
    @term = FactoryGirl.build(:term_sheet, :client, :with_deal)
  end

  subject { @term }

  it { should respond_to(:deal) }
  it { should respond_to(:recipient) }
  # it { should respond_to(:rosters) }
  it { should be_valid }

  # describe "when saved" do
  # 	before(:each) { @term.save }
    
  #   describe "before create callbacks" do
  # 	  it 'sets the default state' do
  #       expect(@term.state).to eq "draft"
  # 	  end

  # 	  it 'sets barcode of not null' do
  #       expect(@term.barcode).to_not eq nil
  # 	  end

  # 	  it 'sets the aqad of tender' do
  #       expect(@term.aqad).to eq @tender.aqad
  # 	  end

  # 	  it 'sets the maturity of tender' do
  #       expect(@term.maturity).to eq @tender.maturity
  # 	  end  	  
  #   end
  # end

end