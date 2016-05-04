require 'rails_helper'

feature "UserCreatesFundraisingFromHouse", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:complete_house, publisher: user) }

  before(:each) { sign_in user }

  describe "via house partial view" do
  	before do
  	  click_link "Pengajuan", match: :first
		  fill_in "tender_annum", with: 10
		  fill_in "tender_seed_capital", with: 20
		  click_button "Ajukan"
	  end

  	it { should have_content('Proposal berhasil dibuat') }
  end

  describe "via request dashboard", js: true do
    before do
      click_link '', :href => '#collapseOne1'
      click_link "Pilih Rumah", match: :first
      click_link "Pilih", match: :prefer_exact
      fill_in "tender_annum", with: 10
      fill_in "tender_seed_capital", with: 20
      click_button "Ajukan"
    end
    after { page.driver.reset! }
    
    it { should have_content('Proposal berhasil dibuat') }
  end  
end