require 'rails_helper'

feature "UserSignsUps", :type => :feature do
	subject { page }
	
	describe "Signing_Up" do
		before { visit new_user_registration_path }

		describe "with invalid information" do
			before { click_button "Daftar" }

			it { should have_title('Daftar') }
		end

		describe "with valid information" do
			before do
				fill_in("user[email]", with: "user@example.com", :match => :prefer_exact)
				fill_in("user[password]", with: "foobarbaz", :match => :prefer_exact)
				fill_in("user[password_confirmation]", with: "foobarbaz", :match => :prefer_exact)
				fill_in("user[full_name]", with: "foobar baz", :match => :prefer_exact)
				fill_in("user[phone_number]", with: "009008007", :match => :prefer_exact)
				choose 'Pemain'
				click_button  "Daftar"
			end

			it { should have_title('Home') }
			it { should have_link('Keluar', href: destroy_user_session_path) }
			it { should_not have_link('Masuk', href: new_user_session_path) }
		end			
	end

end
