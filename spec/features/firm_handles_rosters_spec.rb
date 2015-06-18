require 'rails_helper'

feature "FirmHandlesRosters", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:user_2) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm, :with_subscription) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }

  before do 
  	sign_in user 
  	visit biz_management_path
  	click_link "Ke Halaman Tim"
  end

  describe "rosters list" do
  	it { should have_content(user.full_name) }
  	it { should have_content('Pengelola') }
  end

  describe "adding a non-registered user" do
  	before do
  		click_link "+ Anggota Yang Belum Mendaftar"
      fill_in("roster[user_email]", with: "galliani@example.com")
      # fill_in("roster[user_phone]", with: "0811199194")
      fill_in("roster[password]", with: "foobarbaz")
      fill_in("roster[password_confirmation]", with: "foobarbaz")
      fill_in("roster[full_name]", with: "alex galliani")
      select 'Staff', from: 'roster_role'
      click_button "Simpan"  		
  	end

  	it { should have_content('Pengguna berhasil ditambah ke dalam tim') }
  	it { should have_content('Alex Galliani') }

    describe "signing in as team member" do
      before do
        sign_out
        visit new_user_session_path
        fill_in("user[email]", with: "galliani@example.com")
        fill_in("user[password]", with: "foobarbaz")
        click_button  "Masuk"
      end

      it { should have_content(firm_1.name) }
    end            
  end

  describe "adding a registered user" do
    before do
      click_link "+ Pengguna Yang Terdaftar"
      fill_in("roster[user_email]", with: user_2.email)
      fill_in("roster[full_name]", with: user_2.full_name)
      # fill_in("roster[user_phone]", with: user_2.phone_number)
      select 'Staff', from: 'roster_role'
      click_button "Simpan"     
    end

    it { should have_content('Pengguna berhasil ditambah ke dalam tim') }
    it { should have_content(user_2.full_name) }

    describe "signing in as team member" do
      before do
        sign_out
        visit new_user_session_path
        fill_in("user[email]", with: user_2.email)
        fill_in("user[password]", with: user_2.password)
        click_button  "Masuk"
      end

      it { should have_content(firm_1.name) }
    end                
  end

end
