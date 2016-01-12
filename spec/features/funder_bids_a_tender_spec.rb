require 'rails_helper'

feature "FunderBidsATender", :type => :feature do
  subject { page }
  let!(:user_1) { FactoryGirl.create(:user) } #funder
  let!(:user_2) { FactoryGirl.create(:user) }  #client
  let!(:tender) { FactoryGirl.create(:tender, :murabahah, tenderable: user) }

  before { sign_in user_1 }
  after { page.driver.reset! }

  describe "making a bid", js: true do
  	before do
  	  click_link "Tawar"
  	  fill_in "bid_shares", with: 1000
  	  fill_in "bid_summary", with: "lorem ipsum dolor"
  	  click_button "Simpan"
  	end

  	it { should have_content('Tawaran berhasil diajukan') }

  	context "should have correct information on tender show page" do
  	  it { should have_css('#tender-progress', text: "0 lembar") }
  	  it { should have_css('#bidder-name', text: user_1.name.upcase) }
  	  it { should have_css('#bidder-contribution', text: "RP 500.000.000") }
  	end  	
  end

  context "there is already a bid" do
  	let!(:bid) { FactoryGirl.create(:bid, bidder: user_1, tender: tender) }
  	before(:each) { click_link "Lihat" }

  	describe "correcting a bid", js: true do
  	  before do
  	  	click_link "Edit"
  	  	fill_in "bid_shares", with: 600
  	  	click_button "Simpan"  	  	
  	  end

  	  it { should have_content('Tawaran berhasil dikoreksi') }

  	  context "should have correct information on tender show page" do
  		  it { should have_css('#tender-progress', text: "0 lembar") }
  		  # it { should_not have_css('#tender-state', text: "Qualified") }
  		  it { should have_css('#bidder-contribution', text: "RP 300.000.000") }
  	  end
  	end

  	describe "pulling a bid" do
  	  before do
  	  	click_link "Tarik"
  	  end

  	  it { should have_content('Tawaran berhasil ditarik') }

	  context "should have correct information on tender show page" do
	  	before { click_link "Lihat" }

  		it { should have_css('#tender-progress', text: "0 lembar") }
  		# it { should_not have_css('#tender-state', text: "Qualified") }
  		it { should_not have_css('#bidder-contribution', text: "RP 500.000.000") }
  	  end
  	end
  end

end
