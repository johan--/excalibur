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
  	before do
      click_link "Dukung"
      fill_in 'message', with: 'lorem ipsum dolor casus molar'
      click_button "Kirim"
    end

    it "should display the right button" do
      expect(page).to have_selector('#unlike-button')
      expect(page).to_not have_selector('#like-button')
    end

    it { is_expected.to have_selector('#likers', text: 1) }
    # it { is_expected.to have_content('blablabla') }

  	after { page.driver.reset! }

    context "disapproving of user" do
      before { click_button "Tarik Dukungan" }

      it "should display the right button" do
        expect(page).to_not have_selector('#unlike-button')
        expect(page).to have_selector('#like-button')
      end

      it { is_expected.to have_selector('#likers', text: 0) } 
    end
  end

end