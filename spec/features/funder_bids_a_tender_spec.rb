# require 'rails_helper'

# feature "FunderBidsATender", :type => :feature do
#   subject { page }
#   let!(:funder) { FactoryGirl.create(:user) } #funder
#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:tender) { FactoryGirl.create(:house_purchase_murabaha_tender,
#                   starter: user) }

#   before { sign_in funder }
#   after { page.driver.reset! }

#   describe "making a bid", js: true do
#   	before do
#       click_link tender.ticker
#       click_link "Danai"
#   	  fill_in "Jumlah Saham", with: 1000
#   	  click_button "Simpan"
#   	end

#     it "should display the right message", :retry => 3, :retry_wait => 10 do
#       expect(page).to have_content 'Tawaran berhasil diajukan'
#     end

#     it "should change the shares left" do
#       expect(page).to have_css('#shares-left', text: 0)
#     end

#     it "shows that the starter of the tender also made a bid" do
#         expect(find('#tender-bidder')).to have_selector('li', count: 1)
#     end
    
#     it "should have the name of the bidder" do
#       expect(page).to have_css('.bidder-name', text: funder.name)
#     end
    
#     it { should have_css('#tender-state', text: 'closed') }
#   end

#   # describe "there is already a bid" do
#   # 	let!(:bid) { FactoryGirl.create(:bid, tender: tender, bidder: funder ) }

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