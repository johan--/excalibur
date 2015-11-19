require 'rails_helper'

feature "AdminProcessesNegotiations", :type => :feature do
  subject { page }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user_1) { FactoryGirl.create(:financier) }
  let!(:user_2) { FactoryGirl.create(:client) }
  let!(:tender) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user_2) }


  before(:each) { sign_in admin }
  after { page.driver.reset! }

  describe "processing a document", js: true do
  	let!(:document) { FactoryGirl.create(:document, owner: user_2) }

  	before do 
  	  click_link "Documents"
  	  click_link "Proses"
  	  select "True", from: "document_checked"
  	  click_button "Simpan"
  	end

  	it { should have_content("Dokumen berhasil diproses") }  	
  end

  describe "writing a summary about the proposal", js: true do
  	before do 
  	  # visit admin_tenders_path
  	  click_link "Proposals"
  	  click_link "Proses"
  	  fill_in "tender_summary", with: "lorem ipsum dolor casus molar"
  	  click_button "Simpan"
  	end

  	it { should have_content("Proposal berhasil diproses") }  	
  end

  describe "processing a bid about the proposal", js: true do  	
  	let!(:bid) { FactoryGirl.create(:bid, bidder: user_1, tender: tender) }

  	before do 
  	  # visit admin_bids_path
  	  click_link "Bids"
  	  click_link "Proses"
  	  select "pasti", from: "bid_state"
  	  click_button "Simpan"
  	end

  	it { should have_content("Tawaran berhasil diproses") }
  	it { should have_content("pasti") }
  end

  # describe "processing a contract" do
  # end

end