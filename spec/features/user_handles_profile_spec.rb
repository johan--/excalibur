require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  subject { page }
  
  describe "user fresh after registration", js: true do
    let!(:user_1) { FactoryGirl.create(:user) }

  	before do
      sign_in user_1
  	  click_link("Profil")
      # click_link("Edit", href: edit_user_path(user_1))
  	  fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
      fill_in "user_number_dependents", with: "5"
      fill_in "user_occupation", with: "Karyawan"
      select "D3/Sarjana", :from => 'user_last_education'
  	  select "Belum Menikah", :from => 'user_marital_status'
  	  click_button "Simpan"
  	end

  	it { should have_content("Profil berhasil diperbaharui") }
  end

  # describe "when there is a profile" do
  #   let!(:user_2) { FactoryGirl.create(:user, :with_full_profile) }

  #   before(:each) do 
  #     sign_in user_2
  #     visit user_root_path 
  #   end

  #   context "viewing the profile page" do
  #     before { click_link("Lihat", match: :first) }

  #     it { should have_css('#name', text: user_2.name) }
  #     it { should have_css('#bio', text: user_2.about) }
  #   end
  # end

end
