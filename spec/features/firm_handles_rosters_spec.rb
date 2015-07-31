require 'rails_helper'

feature "FirmHandlesRosters", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:entrepreneur, :with_team) }
  let!(:user_2) { FactoryGirl.create(:entrepreneur) }

  before do 
  	sign_in user 
  	visit biz_management_path
  	click_link "Ke Halaman Tim"
  end

  # describe "rosters list" do
  # 	it { should have_content(user.name) }
  # 	it { should have_content('Pengelola') }
  # end

  # describe "adding a non-registered user" do
  # 	before do
  # 		click_link "+ Yang Belum Mendaftar"
  #     fill_in("roster[user_email]", with: "galliani@example.com")
  #     # fill_in("roster[user_phone]", with: "0811199194")
  #     fill_in("roster[password]", with: "foobarbaz")
  #     fill_in("roster[password_confirmation]", with: "foobarbaz")
  #     fill_in("roster[name]", with: "alex galliani")
  #     select 'Staff', from: 'roster_role'
  #     click_button "Simpan"  		
  # 	end

  # 	it { should have_content('Pengguna berhasil ditambah ke dalam tim') }
  # 	it { should have_content('Alex Galliani') }

  #   describe "signing in as team member" do
  #     before do
  #       sign_out
  #       visit new_user_session_path
  #       fill_in("user[email]", with: "galliani@example.com")
  #       fill_in("user[password]", with: "foobarbaz")
  #       click_button  "Masuk"
  #     end

  #     it { should have_content(user.firm_locator.name) }
  #   end            
  # end

  # describe "adding a registered user" do
  #   before do
  #     click_link "+ Yang Terdaftar"
  #     fill_in("roster[user_email]", with: user_2.email)
  #     fill_in("roster[name]", with: user_2.name)
  #     # fill_in("roster[user_phone]", with: user_2.phone_number)
  #     select 'Staff', from: 'roster_role'
  #     click_button "Simpan"     
  #   end

  #   it { should have_content('Pengguna berhasil ditambah ke dalam tim') }
  #   it { should have_content(user_2.name) }

  #   describe "signing in as team member" do
  #     before do
  #       sign_out
  #       visit new_user_session_path
  #       fill_in("user[email]", with: user_2.email)
  #       fill_in("user[password]", with: user_2.password)
  #       click_button  "Masuk"
  #     end

  #     it { should have_content(user.firm_locator.name) }
  #   end                
  # end

end
