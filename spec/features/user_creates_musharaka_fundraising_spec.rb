require 'rails_helper'

feature "UserCreatesMusharakaFundraising", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:house) }

  before(:each) { sign_in user }
  after { page.driver.reset! }
  
  describe "creating a musharaka fundraising tender", js: true do
	before do
	  click_link "Pendanaan"
	  click_link "Pilih"
	  select 'musharaka', from: "tender[aqad]"
	  fill_in "Modal Kamu", with: 20
	  fill_in "Durasi", with: 8
	  click_button "Kirim"
	end

	it { should have_content('Proposal berhasil dibuat') }

	describe "should have correct information on tender show page" do
	  # it { should have_css('#price-share', text: "Rp 300.000") }
	  it { should have_css('#tender-aqad', text: "Musharaka") }
	  it { should have_css('#shares-left', text: 800) }
	end

	it "shows that the starter of the tender also made a bid" do
   	  expect(find('#tender-bidder')).to have_selector('li', count: 1)
	end
  end

end