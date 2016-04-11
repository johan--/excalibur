require 'rails_helper'

feature "UserEditsHouses", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:complete_house, publisher: user) }  
  
  before(:each) { sign_in user }


  describe "editing complete house" do  	
    before do
	  click_link("Edit")
	  fill_in "house_price", with: 250000000
	  click_button "Simpan"
	end

  	it { should have_content('Rumah berhasil dikoreksi') }

	context "should have correct information on tender show page" do
	  it { should have_css('#house-price', text: "Rp 250 jt") }
	end
  end


end