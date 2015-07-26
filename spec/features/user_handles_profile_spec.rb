require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  subject { page }
  
  let!(:user) { FactoryGirl.create(:player) }
  
  before { sign_in user }

  describe "creating a profile for current user" do
  	before do
  	  click_link "Buat Profil Pengguna"
  	  fill_in "user_profile_about", with: "Lorem Ipsum Dolor Casuss"
      select "D3/Sarjana", :from => 'user_profile_details_last_education'
  	  select "Belum Menikah", :from => 'user_profile_details_marital_status'
  	  click_button "Simpan"
  	end

  	it { should have_content("Profil berhasil dibuat") }
    it { should have_link("Lihat Profil") }
  end

end
