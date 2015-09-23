require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  subject { page }
  
  describe "user fresh after registration" do
    let!(:user_1) { FactoryGirl.create(:client) }
    before { sign_in user_1 }

    context "creating one", js: true do
    	before do
    	  visit user_root_path
    	  click_link("Edit")
        # click_link("Edit", href: edit_user_path(user_1))
        fill_in "user_phone_number", with: "08139898989"
    	  fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
        select "D3/Sarjana", :from => 'user_last_education'
    	  select "Belum Menikah", :from => 'user_marital_status'
    	  click_button "Simpan"
    	end

    	it { should have_content("Profil berhasil diperbaharui") }
      it { should have_link("Lihat") }
    end
  end

  describe "when there is a profile" do
    let!(:user_2) { FactoryGirl.create(:client, :with_full_profile) }

    before(:each) do 
      sign_in user_2
      visit user_root_path 
    end

    context "viewing the profile modal", js: true do
      before { click_link("Lihat") }

      it { should have_css('#name', text: user_2.name) }
      it { should have_css('#bio', text: user_2.about) }
    end
  end

end
