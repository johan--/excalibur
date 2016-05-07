require 'rails_helper'

feature "UserEditsHouses", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:complete_house, publisher: user) }  
  
  before(:each) { sign_in user }


  describe "editing complete house" do  	
    before do
	    # click_link("Edit")
      find('#house-edit').click
	    fill_in "house_price", with: 250000000
	    click_button "Simpan"
	  end

  	it { should have_content('Rumah berhasil dikoreksi') }

	  context "should have correct information on tender show page" do
	    it { should have_content("Rp 250.000.000") }
	  end
  end


end