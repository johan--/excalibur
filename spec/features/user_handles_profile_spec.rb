require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }
  subject { page }
  
  before(:each) { sign_in user }

  describe "user fresh after registration" do
  	before do
      click_link '', :href => '#collapseOne1'
      click_link "Kelola"
  	  click_link "Isi Profil"
  	  fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
      fill_in "user_number_dependents", with: "5"
      fill_in "user_occupation", with: "Karyawan"
      fill_in "user_monthly_income", with: 1500000
      fill_in "user_monthly_expense", with: 1500000
      select "D3/Sarjana", :from => 'user_last_education'
  	  select "Belum Menikah", :from => 'user_marital_status'
      fill_in "user_work_experience", with: "Lorem Ipsum Dolor Casuss"
      fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
  	  click_button "Simpan"
  	end

  	it { should have_content("Profil berhasil diperbaharui") }
  end
end