require 'rails_helper'

feature "UserAuthenticatesWithOmniauth", :type => :feature do
  let!(:user) { FactoryGirl.create(:google_user) }

  subject { page }

  before do 
  	visit root_path
  	click_link "Masuk" 
  end

  describe "login with Facebook" do
    before do
      mock_auth_hash_facebook
	  click_link 'Facebook'
	end

	it { should have_content('Home') }
	it { should have_content('Hai, Facebooker') }
	it { should have_content('facebooker@example.com') }
  end

  describe "login with google" do
    background do   	
      mock_auth_hash_google
	  click_link 'Google'
	end

	it { should have_content('Home') }
	it { should have_content('Hai, Googler') }
  end


  describe "when authentication error" do
  	before do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      click_link 'Facebook'
    end

    it { should have_content('Authentication failed because') }
  end

end