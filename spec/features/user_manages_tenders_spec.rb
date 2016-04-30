require 'rails_helper'

feature "UserManagesTenders", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }

  before(:each) { sign_in user }

  describe "via request dashboard" do
  	before do
  	  click_link "Kelola", match: :first
		  fill_in "tender_annum", with: 8
		  fill_in "tender_seed_capital", with: 25
		  click_button "Kirim"
	  end

  	it { should have_content('Proposal berhasil diperbarui') }
  end
end