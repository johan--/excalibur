require 'rails_helper'

feature "FirmChangesPreferences", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm) }
  let!(:sub_1) { FactoryGirl.create(:active_1_mo, firm: firm_1) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }

  before { sign_in user }

  describe "into the preference form" do
    before do
      click_link "Halaman Manajemen", match: :first
      click_link "Ke Halaman Preferensi"   
      select "0.75", from: "firm_pref[dp_percent]"
      click_button "Simpan"
    end

    it { should have_content("Preferensi bisnis berhasil dikoreksi") }
  end
  
end
