require 'rails_helper'

feature "FirmChangesVenuePreferences", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm) }
  let!(:sub_1) { FactoryGirl.create(:active_1_mo, firm: firm_1) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }

  before { sign_in user }

  describe "into the preference form", js: true do
  	before do
  		click_link "Preferensi"		
  		select "Minggu", from: "venue_pref[day_active]"
  		fill_in "venue_pref[day_increase]", with: "30000"
  		click_button "Simpan"
  	end

  	it { should have_content('Preferensi Arena berhasil dikoreksi') }
  end

end
