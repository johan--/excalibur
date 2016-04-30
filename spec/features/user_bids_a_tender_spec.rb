require 'rails_helper'

feature "UserBidsATender", :type => :feature do
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

  describe "making a bid" do
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
      # expect(page).to have_css '#progress-info', text: '100% Tercapai'
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

    
    # it "should have the name of the bidder" do
    #   expect(page).to have_css('.bidder-name', text: bidder.name)
    # end
  end

  # describe "there is already a bid" do
  # 	let!(:bid) { FactoryGirl.create(:bid, tender: tender, bidder: bidder ) }

  # 	describe "correcting a bid", js: true do
  # 	  before do
  #       visit tender_path(tender)
  # 	  	click_link "Edit"
  # 	  	fill_in "Jumlah Saham", with: 500
  # 	  	click_button "Simpan"  	  	
  # 	  end

  # 	  it { should have_content('Tawaran berhasil dikoreksi') }

  # 	  context "should have correct information on tender show page" do
  #       it { should have_css('#tender-progress', text: "500 Lembar Tersisa") }
  #       it { should have_css('#tender-state', text: 'open') }
  #       it { should have_css('.bid-volume', text: 500) }
  # 	  end
  # 	end

  # 	describe "pulling a bid" do
  # 	  before do
  #       visit tender_path(tender)
  # 	  	click_link "Tarik"
  # 	  end

  # 	  it { should have_content('Tawaran berhasil ditarik') }

  # 	  context "should have correct information on tender show page" do
  #       it { should have_css('#tender-progress', text: "1000 Lembar Tersisa") }
  #       it { should have_css('#tender-state', text: 'open') }
  #   	end
  #   end
  # end

end