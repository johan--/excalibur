require 'rails_helper'

feature "UserSignsUp", :type => :feature do
	let!(:user) { FactoryGirl.attributes_for(:user) }
	subject { page }
	
	describe "Signing_Up" do
		before do 
		  visit root_path
		  find('#extra-link').click
		  within(:li, '#extra-menu') do
		  	click_link "Sign up"
		  end		  
		end

		describe "as beta-listed client with valid information" do
			before do
				fill_in("user[email]", with: user[:email])
				fill_in("user[password]", with: user[:password])
				fill_in("user[password_confirmation]", with: user[:password_confirmation])
				fill_in("user[name]", with: user[:name])
				fill_in("user[phone_number]", with: user[:phone_number])
				check "user[understanding]"
				click_button "Daftar"
			end

			it { should have_title('Home | SiKapiten') }
			it { should have_content('Welcome! You have signed up successfully') }
			it { should_not have_link('Masuk', href: new_user_session_path) }
		end
	end

end
