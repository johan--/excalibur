require 'rails_helper'

feature "UserHandlesProfile", :type => :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }
  subject { page }
  
  before(:each) { sign_in user }

  describe "user fresh after registration" do
  	before do
  	  click_link "Lihat profil"
      click_link "Isi profil"
      fill_in "user_number_dependents", with: "5"
      fill_in "user_occupation", with: "Karyawan"
      fill_in "user_monthly_income", with: 1500000
      fill_in "user_monthly_expense", with: 1500000
      fill_in 'user_last_education', with: "D3"
  	  select "Belum Menikah", :from => 'user_marital_status'
      fill_in "user_work_experience", with: "Lorem Ipsum; Dolor Casuss; Molar Molor"
      fill_in "user_about", with: "Lorem Ipsum Dolor Casuss"
  	  click_button "Simpan"
  	end

  	it { should have_content("Profil berhasil diperbaharui") }
    it { is_expected.to have_selector('#user-occupation', text: "Karyawan") }
    it { is_expected.to have_selector('#user-family', text: "Belum Menikah dan memiliki 5 individu sebagai tanggungan") }
    it { is_expected.to have_selector('#user-education', text: "D3") }
    # it { should have_content("blablablabla") }
  end


end