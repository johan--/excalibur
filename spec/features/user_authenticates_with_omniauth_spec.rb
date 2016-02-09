require 'rails_helper'

feature "UserAuthenticatesWithOmniauth", :type => :feature do
  # let!(:facebooker) { FactoryGirl.create(:facebook_user) }
  # let!(:facebooker) { FactoryGirl.create(:linkedin_user) }

  subject { page }

  before do 
  	# visit root_path
  	# click_link "Masuk" 
    visit new_user_session_path
  end

  describe "login with Facebook" do
    before do
      mock_auth_hash_facebook
	  click_link 'Sign in via Facebook'
	end

	  # it { should have_content('Beranda') }
	  it { should have_content('Hai, Facebooker') }
  end

  describe "login with linkedin" do
    background do   	
      mock_auth_hash_google
	  click_link 'Sign in via Linkedin'
	end

	  # it { should have_content('Beranda') }
	  it { should have_content('Hai, Link') }
  end

 #  describe "login with google" do
 #    background do   	
 #      mock_auth_hash_google
	#   click_link 'Google'
	# end

	#   # it { should have_content('Beranda') }
	#   it { should have_content('Hai, Googler') }
 #  end


  describe "when authentication error" do
  	before do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      click_link 'Facebook'
    end

    it { should have_content('Authentication failed because') }
  end

end