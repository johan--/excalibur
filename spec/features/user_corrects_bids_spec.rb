require 'rails_helper'

feature "UserCorrectsBids", :type => :feature do
  subject { page }
  let!(:bidder) { FactoryGirl.create(:user) } 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }
  let!(:bid) { FactoryGirl.create(:bid, tender: proposal, volume: 800, bidder: bidder) }
  
  before(:each) do 
    sign_in bidder 
  	visit tender_path(proposal)
  	click_link "Edit", href: edit_tender_bid_path(proposal, bid)    
  end
  after { page.driver.reset! }

	context "editing his/her bid", js: true do
	  before do
	    fill_in 'Jumlah Saham', with: 500
	    find('#bid-form-button').click
	    find('#bid-folder').click
	  end
	  
	  it { is_expected.to have_content 'Tawaran berhasil dikoreksi'}
	  it { is_expected.to have_css '.bid-volume', text: '500' }
	  it { is_expected.to have_css '.bid-value', text: 'Rp 150.000.000' }
	  it { is_expected.to have_selector '.bid-card', count: 1 }
	end  

	context "withdrawing his/her bid", js: true do
	  before do
	    click_link "Tarik Tawaran"
	    find('#bid-folder').click
	  end
		
	  it { is_expected.to have_content 'Tawaran berhasil ditarik'}
	  # it { is_expected.to have_content 'blablabla'}
	  it { is_expected.to_not have_css '.bid-volume', text: '800' }
	  it { is_expected.to_not have_css '.bid-value', text: 'Rp 240.000.000' }
	  it { is_expected.to have_selector '.bid-card', count: 0 }
	end

  
end