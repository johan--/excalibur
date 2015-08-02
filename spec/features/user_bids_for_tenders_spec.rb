require 'rails_helper'

feature "UserBidsForTenders", :type => :feature do
  subject { page }
  let!(:investor) { FactoryGirl.create(:investor) }
  let!(:consumer) { FactoryGirl.create(:consumer) }
  let!(:user) { FactoryGirl.create(:entrepreneur) }
  let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }
  let!(:tender_1) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }
  let!(:tender_2) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: consumer) }

  before { sign_in investor }

  describe "viewing the tenders list" do
  	it { should have_css('.tender-title', text: tender_1.barcode) }
  	it { should have_css('.tender-title', text: tender_2.barcode) }
  end

  describe "viewing a tender by business" do
  	before { click_link tender_1.barcode }

  	it { should have_css('.caption-subject', text: tender_1.barcode) }

  	context "making a bid" do
  	  before do
  	  	click_link "Buat Tawaran"
  	  	fill_in "bid_contribution", with: 1500000
  	  	click_button "Simpan"
  	  end
	  
	  it { should have_content('Tawaran berhasil diajukan') }

	  context "when return to home" do
	  	before { visit user_root_path }

	  	it { should have_css(".tenderable-name", text: tender_1.tenderable.name) }
	  	it { should have_css(".contribution", text: "Rp 1.500.000") }
	  end
  	end
  end

end