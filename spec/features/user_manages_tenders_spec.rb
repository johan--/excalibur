require 'rails_helper'

feature "UserManagesTenders", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }

  before(:each) { sign_in user }

  describe "via request dashboard" do
  	before do
  	  # click_link "Kelola", match: :first
      page.find('.edit-proposal').click
		  fill_in "tender_annum", with: 8
		  fill_in "tender_seed_capital", with: 25
		  click_button "Kirim"
	  end

  	it { should have_content('Proposal berhasil diperbarui') }
  end

  describe "via tender show page" do
    before do
      click_link proposal.ticker
      click_link "Kelola Proposal"
    end

    context "destroying proposal" do
      before { click_link "Hapus Proposal" }

      it { should have_content('Proposal berhasil dihapus') }
    end
  end

end