require 'rails_helper'

feature "UserSignsIn", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "via navbar" do
	before do
	  visit root_path
	  find('#extra-link').click
	  within(:li, '#extra-menu') do
	  	click_link "Log in"
	  end
	  fill_in("user[email]", with: user.email)
	  fill_in("user[password]", with: user.password)
	  click_button  "Masuk"
	end

	it { should have_title('Home | SiKapiten') }
  end

end