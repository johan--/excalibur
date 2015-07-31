require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  subject { page }
  
  describe "user fresh after registration" do
    let!(:user_1) { FactoryGirl.create(:entrepreneur) }
    before { sign_in user_1 }

    context "creating one", js: true do
    	before do
    	  click_link "Edit Profilku"
        fill_in "user_phone_number", with: "08139898989"
    	  fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
        select "D3/Sarjana", :from => 'user_last_education'
    	  select "Belum Menikah", :from => 'user_marital_status'
    	  click_button "Simpan"
    	end

    	it { should have_content("Profil berhasil diperbaharui") }
      it { should have_link("Lihat Profilku") }
    end
  end

  describe "when there is a profile" do
    let!(:user_2) { FactoryGirl.create(:entrepreneur, :with_full_profile) }

    before(:each) do 
      sign_in user_2
      visit user_root_path 
    end

    context "viewing the profile modal", js: true do
      before { click_link "Lihat Profilku" }

      it { should have_css('.name', text: user_2.name) }
      it { should have_css('#education', text: user_2.last_education) }
      it { should have_css('#marital', text: user_2.marital_status) }
    end

    context "editing the profile", js: true do
      before do 
        click_link "Edit Profilku" 
        fill_in "user_about", with: "Blabla galih blabla"
        click_button "Simpan"
      end

      it { should have_content("Profil berhasil diperbaharui") }

      it "shows changes on the show profile page", js: true do
        click_link "Lihat Profilku"

        expect(page).to have_css('.bio', text: "Blabla galih blabla") 
      end
    end
  end

end
