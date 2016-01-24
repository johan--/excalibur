require 'rails_helper'

feature "UserCreatesTender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.create(:house) }
  # let!(:stock) { FactoryGirl.create(:stock, house: house) }

  before(:each) { sign_in user }
  after { page.driver.reset! }
  
  describe "creating a murabahah fundraising tender", js: true do
	before do
	  # click_link("Klien")
	  click_link "Buat Pengajuan"
	  click_link "Pilih Murabahah"
	  fill_in "Modal Kamu", with: 20
	  fill_in "Lama Kontrak", with: 10
	  select house.ticker, from: "Rumah Pilihan"
	  click_button "Kirim"
	end


	it { should have_content('Proposal berhasil dibuat') }

	# describe "should have correct information on tender show page" do
	#   it { should have_css('#tender-target', text: house.price) }
	#   it { should have_css('#aqad', text: "murabaha") }
	#   it { should have_css('#tender-maturity', text: "10 Tahun") }
	# end
  end


end