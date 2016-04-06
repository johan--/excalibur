require 'rails_helper'

# feature "UserEditsFundraisings", :type => :feature do
#   subject { page }

#   let!(:user) { FactoryGirl.create(:user) }
#   let!(:tender) { FactoryGirl.create(:house_purchase_musharaka_tender, 
#     	  								starter: user) }

#   before(:each) { sign_in user }
#   after { page.driver.reset! }
  
#   describe "editing a musharaka fundraising tender", js: true do
#   	before do
#   	  visit tender_path(tender)
#   	  click_link "Edit"
#   	  within('#edit_tender_1') do
#   	  	fill_in "Modal Kamu", with: 50
#   	  	click_button "Kirim"
#   	  end
#   	end

#   	# describe "it should generate the right response" do
#   	  it "should display the right message", :retry => 3, :retry_wait => 10 do
#   	  	expect(page).to have_content 'Proposal berhasil dikoreksi'
#   	  end
  	  
#   	  it "should change the shares left" do
#   	  	expect(page).to have_css('#shares-left', text: 500)
#   	  end  	  

# 	  it "shows that the starter of the tender also made a bid" do
#    	    expect(find('#tender-bidder')).to have_selector('li', count: 1)
# 	  end	
# 	# end
#   end


# end