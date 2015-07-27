require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  subject { page }
  
  let!(:user) { FactoryGirl.create(:player) }
  
  before { sign_in user }

  describe "when there is no profile for current user" do
    context "creating one", js: true do
    	before do
    	  click_link "Buat Profil Pengguna"
    	  fill_in "user_profile_about", with: "Lorem Ipsum Dolor Casuss"
        select "D3/Sarjana", :from => 'user_profile_details_last_education'
    	  select "Belum Menikah", :from => 'user_profile_details_marital_status'
    	  click_button "Simpan"
    	end

    	it { should have_content("Profil berhasil dibuat") }
      it { should have_link("Lihat Profilku") }
    end
  end

  describe "when there is a profile" do
    let!(:user_prof) { FactoryGirl.create(:user_profile, profileable: user) }
    before(:each) { visit user_root_path }

    context "on the home page" do
      it { should have_link("Lihat Profilku") }
      it { should have_link("Edit Profilku") }
      it { should have_no_link("Buat Profil") }
    end

    context "viewing the profile modal", js: true do
      before { click_link "Lihat Profilku" }

      it { should have_css('.profileable-name', text: user_prof.profileable.full_name) }
      it { should have_css('#education', text: user_prof.details[:last_education]) }
      it { should have_css('#marital', text: user_prof.details[:marital_status]) }
    end

    context "editing the profile", js: true do
      before do 
        click_link "Edit Profilku" 
        fill_in "user_profile_about", with: "Blabla galih blabla"
        click_button "Simpan"
      end

      it { should have_content("Profil berhasil dikoreksi") }

      it "shows changes on the show profile page", js: true do
        click_link "Lihat Profilku"

        expect(page).to have_css('.bio', text: "Blabla galih blabla") 
      end
    end
  end

end
