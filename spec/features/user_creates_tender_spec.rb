require 'rails_helper'

feature "UserCreatesTender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:house) { FactoryGirl.build(:house) }

  before(:each) { sign_in user }
  # after { page.driver.reset! }
  
  describe "when there is no tender yet" do
	context "creating a murabahah tender" do
	  before do
	    # click_link("Klien")
	    # click_link "Ajukan Pendanaan"
	    click_link "Ajukan Murabahah"
	    fill_in "Lama Cicilan", with: 10
	    fill_in "Uang Muka", with: 20
	    select house.ticker, from: "Rumah Terkait"
	    click_button "Simpan"
	  end


	  it { should have_content('Proposal berhasil dibuat') }

	  describe "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: house.price) }
	    it { should have_css('#aqad', text: "murabaha") }
	    it { should have_css('#tender-maturity', text: "10 Tahun") }
	  end
	end

	# context "creating a musyarakah tender" do
	#   before do
	    # click_link("Klien")
	    # click_link "Ajukan Pendanaan"
	    # click_link "Ajukan Musyarakah"
	    # fill_in "tender_seed_capital", with: 10
	    # fill_in "tender_annum", with: 10
	    # select house.ticker, from: "tender_house"
	    # click_button "Simpan"
	#   end
	    
	#   it { should have_content('Proposal berhasil dibuat') }

	  # context "should have correct information on tender show page" do
	  #   it { should have_css('#aqad', text: "musharaka") }
	  #   it { should have_css('#tender-maturity', text: "10 Tahun") }
	  # end
	# end	
  end

 #  describe "when there is a murabahah tender" do
	# let!(:tender) { FactoryGirl.create(:tender, :murabahah, starter: user) }

	# describe "editing the tender", js: true do
	#   before do
	#     visit user_root_path
	#     # click_link("Pembiayaan", href: '#portlet_tab1')
	#     click_link("Pembiayaan")
	#     click_link("Edit", href: edit_user_tender_path(user, tender))
	#     fill_in "tender_price", with: 400000000
	#     click_button "Simpan"
	#   end

	#   it { should have_content('Proposal berhasil dikoreksi') }
		
	#   context "should have correct information on tender show page" do
	#     it { should have_css('#tender-target', text: "Rp 400.000.000") }
	#     it { should have_css('#tender-pps', text: "Rp 400.000") }
	#   end
	# end
 #  end

end