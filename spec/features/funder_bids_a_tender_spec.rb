require 'rails_helper'

feature "FunderBidsATender", :type => :feature do
  subject { page }
  let!(:funder) { FactoryGirl.create(:user) } #funder
  let!(:tender) { FactoryGirl.create(:tender, :murabaha, 
                        :house_purchase) }

  before do 
    sign_in funder 
  end
  after { page.driver.reset! }

  describe "making a bid", js: true do
  	before do
      visit tender_path(tender)
      click_link "Danai"
  	  fill_in "Jumlah Saham", with: 1000
  	  click_button "Simpan"
  	end

  	it { should have_content('Tawaran berhasil diajukan') }

  	context "should have correct information on tender show page" do
  	  it { should have_css('#tender-progress', text: "0 Lembar Tersisa") }
      it { should have_css('#tender-state', text: 'closed') }
  	  it { should have_css('.user-name', text: funder.name) }
  	  it { should have_css('.bid-volume', text: 1000) }
  	end  	
  end

  describe "there is already a bid" do
  	let!(:bid) { FactoryGirl.create(:bid, tender: tender, bidder: funder ) }

  	describe "correcting a bid", js: true do
  	  before do
        visit tender_path(tender)
  	  	click_link "Edit"
  	  	fill_in "Jumlah Saham", with: 500
  	  	click_button "Simpan"  	  	
  	  end

  	  it { should have_content('Tawaran berhasil dikoreksi') }

  	  context "should have correct information on tender show page" do
        it { should have_css('#tender-progress', text: "500 Lembar Tersisa") }
        it { should have_css('#tender-state', text: 'open') }
        it { should have_css('.bid-volume', text: 500) }
  	  end
  	end

  	describe "pulling a bid" do
  	  before do
        visit tender_path(tender)
  	  	click_link "Tarik"
  	  end

  	  it { should have_content('Tawaran berhasil ditarik') }

  	  context "should have correct information on tender show page" do
        it { should have_css('#tender-progress', text: "1000 Lembar Tersisa") }
        it { should have_css('#tender-state', text: 'open') }
    	end
    end
  end

end