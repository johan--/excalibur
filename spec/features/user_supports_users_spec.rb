require 'rails_helper'

feature "UserSupportsUsers", :type => :feature do
  subject { page }
  let!(:bidder) { FactoryGirl.create(:user) } 
  let!(:user) { FactoryGirl.create(:user) }

  before do 
    sign_in bidder 
    visit user_path(user)
  end
  # after { page.driver.reset! }

  context "making a bid" do
  	before(:each) do
      # click_link proposal.ticker
      within(:div, '#tender-bidding') do
  	    fill_in 'volume', with: 800
        click_button "Kirim"
      end
  	end
    

    it "should display the right message" do
      expect(page).to have_content 'Tawaran berhasil diajukan'
    end

    it "should display the progress to be complete" do
      expect(page).to have_content '100% Tercapai'
    end

    it "shows that the bid is listed" do
      expect(page).to have_selector('li.bid-item', count: 2)
    end
  end

end