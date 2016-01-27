require 'rails_helper'

feature "UserCreatesMurabahaFundraising", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:house) }
  # let!(:stock) { FactoryGirl.create(:stock, house: house) }

  before(:each) { sign_in user }
  after { page.driver.reset! }
  
  describe "creating a murabahah fundraising tender", js: true do
	before do
	  click_link "Pendanaan"
	  click_link "Pilih"
	  select 'murabaha', from: "tender[aqad]"
	  fill_in "Modal Kamu", with: 20
	  fill_in "Durasi", with: 10
	  # range_select("tender[annum]", 10)
	  # range_select("tender[seed_capital]", 25)
	  # find(:xpath, "//input[@id='tender_seed_capital']").set 8
	  # find(:xpath, "//input[@id='tender_annum']").set 25
	  # page.find('#tender_seed_capital').drag_by(8, 0)
	  # page.find('#tender_annum').drag_by(30, 0)
	  click_button "Kirim"
	end

	it { should have_content('Proposal berhasil dibuat') }

	it "shows that the info of the starter" do
   	  expect(find('#starter-info')).to have_selector('div.inf-content', count: 1)
	end

	it "shows that the starter of the tender should not have made a bid" do
   	  expect(find('#tender-bidder')).to have_selector('li', count: 0)
	end

	describe "should have correct information on tender show page" do
	  it { should have_css('#price-share', text: "Rp 300000,00 / unit") }
	  it { should have_css('#tender-aqad', text: "Murabaha") }
	  it { should have_css('#shares-left', text: house.initial_stock.volume) }
	end
  end


end