# require 'rails_helper'

# feature "UserCorrectsBids", :type => :feature do
#   subject { page }
#   let!(:bidder) { FactoryGirl.create(:user) } 
#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
#                                         starter: user) }

#   before do 
#     sign_in bidder 
#     visit tender_path(proposal)
#   end
#   # after { page.driver.reset! }

#   # describe "there is already a bid" do
#   # 	let!(:bid) { FactoryGirl.create(:bid, tender: tender, bidder: bidder ) }

#   # 	describe "correcting a bid", js: true do
#   # 	  before do
#   #       visit tender_path(tender)
#   # 	  	click_link "Edit"
#   # 	  	fill_in "Jumlah Saham", with: 500
#   # 	  	click_button "Simpan"  	  	
#   # 	  end

#   # 	  it { should have_content('Tawaran berhasil dikoreksi') }

#   # 	  context "should have correct information on tender show page" do
#   #       it { should have_css('#tender-progress', text: "500 Lembar Tersisa") }
#   #       it { should have_css('#tender-state', text: 'open') }
#   #       it { should have_css('.bid-volume', text: 500) }
#   # 	  end
#   # 	end

#   # 	describe "pulling a bid" do
#   # 	  before do
#   #       visit tender_path(tender)
#   # 	  	click_link "Tarik"
#   # 	  end

#   # 	  it { should have_content('Tawaran berhasil ditarik') }

#   # 	  context "should have correct information on tender show page" do
#   #       it { should have_css('#tender-progress', text: "1000 Lembar Tersisa") }
#   #       it { should have_css('#tender-state', text: 'open') }
#   #   	end
#   #   end
#   # end

# end