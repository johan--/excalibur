require 'rails_helper'

feature "UserCreatesTender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }

  before { sign_in user }
  after { page.driver.reset! }
  
  describe "when there is no tender yet", js: true do
	context "creating a murabahah tender" do
	  before do
	    visit user_root_path
	    click_link("", href: '#portlet_tab1')
	    click_link "Ajukan Murabahah"
	    select "tempat tinggal", from: "tender_intent"
	    fill_in "tender_price", with: 500000000
	    fill_in "tender_own_capital", with: 30
	    fill_in "tender_maturity", with: 8
	    fill_in "tender_address", with: "Jl. Lorem No. 99"
	    select "rumah tunggal", from: "tender_tangible"
	    choose "Ya"
	    click_button "Simpan"
	  end
	    
	  it { should have_content('Proposal berhasil dibuat') }

	  context "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: "Rp 500.000.000") }
	    it { should have_css('#tender-client', text: user.name) }
	    it { should have_css('#tender-maturity', text: "8 Tahun") }
	  end
	end

	context "creating a musyarakah tender" do
	  before do
	    visit user_root_path
	    click_link("", href: '#portlet_tab1')
	    click_link "Ajukan Musyarakah"
	    select "pembelian", from: "tender_use_case"
	    select "tempat tinggal", from: "tender_intent"
	    fill_in "tender_price", with: 500000000
	    fill_in "tender_own_capital", with: 25
	    fill_in "tender_maturity", with: 8
	    fill_in "tender_address", with: "Jl. Lorem No. 99"
	    select "rumah tunggal", from: "tender_tangible"
	    choose "Ya"
	    click_button "Simpan"
	  end
	    
	  it { should have_content('Proposal berhasil dibuat') }

	  context "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: "Rp 375.000.000") }
	    it { should have_css('#tender-pps', text: "Rp 500.000") }
	  end
	end	
  end

  describe "when there is a murabahah tender" do
	let!(:tender) { FactoryGirl.create(:tender, :murabahah, tenderable: user) }

	describe "editing the tender", js: true do
	  before do
	    visit user_root_path
	    # click_link("Pembiayaan", href: '#portlet_tab1')
	    click_link("Pembiayaan")
	    click_link("Edit", href: edit_user_tender_path(user, tender))
	    fill_in "tender_price", with: 400000000
	    click_button "Simpan"
	  end

	  it { should have_content('Proposal berhasil dikoreksi') }
		
	  context "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: "Rp 400.000.000") }
	    it { should have_css('#tender-pps', text: "Rp 400.000") }
	  end
	end
  end

end