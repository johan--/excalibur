require 'rails_helper'

feature "UserBidsTenders", :type => :feature do
  subject { page }
  let!(:bidder) { FactoryGirl.create(:user) } 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }

  before do 
    sign_in bidder 
    visit tender_path(proposal)
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

    # it "shows that the starter of the tender also made a bid" do
    #   expect(page).to have_selector('li.bid-item', count: 2)
    # end

    # it "should change the shares left", :retry => 3, :retry_wait => 10 do
    #   expect(page).to have_css('#shares-left', text: 0)
    # end
  end

end