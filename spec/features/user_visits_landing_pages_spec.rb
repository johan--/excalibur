require 'rails_helper'

feature "UserVisitsLandingPages", :type => :feature do
  subject { page }

  describe "visiting landing page" do
  	before { visit root_path }

	it { should have_content('Platform Pembiayaan Syariah Untuk Usahamu') }

  	context "subscribing through subscribe form" do
  	  before do
  	  	within(:div, '#landing-subscriber') do
  	  	  fill_in "email", with: "foobar@example.com"
  	  	  click_button "Simpan Email"
  	  	end
  	  end

  	  it { should have_content('Terima kasih, kami akan kabari kamu') }
  	end
  end

end
