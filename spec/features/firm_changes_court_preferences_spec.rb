require 'rails_helper'

feature "FirmChangesCourtPreferences", :type => :feature do
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
      click_link "Tarif"
  		click_link "Atur", match: :first
  		# select "Minggu", from: "court_pref[day_active]"
  		fill_in "court_pref[day_increase]", with: "40000"
  		click_button "Simpan"
  	end

  	it { should have_content("Preferensi #{venue_1.courts.last.name} 
      berhasil dikoreksi") }
  end

end
