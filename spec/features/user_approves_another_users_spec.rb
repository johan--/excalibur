require 'rails_helper'

feature "UserApprovesAnotherUsers", type: :feature do
  subject { page }
  let!(:bidder) { FactoryGirl.create(:user) } 
  let!(:user) { FactoryGirl.create(:user) }

  before do 
    sign_in bidder 
    visit user_path(user)
  end
  

  context "approving a user", js: true do
  	before { click_button "Dukung" }
  	after { page.driver.reset! }

    it "should display the right button" do
      expect(page).to have_selector('#unlike-button')
      expect(page).to_not have_selector('#like-button')
    end

    it { is_expected.to have_selector('#likers', text: 1) }
  end

end