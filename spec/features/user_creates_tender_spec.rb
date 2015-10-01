require 'rails_helper'

feature "UserCreatesTender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:client) }

  before { sign_in user }

  describe "when there is no tender yet" do
	context "creating a murabahah tender", js: true do
	  before do
	    visit user_root_path
	    click_link("", href: '#portlet_tab1')
	    click_link "Ajukan Murabahah"
	    fill_in "tender_price", with: 500000000
	    fill_in "tender_address", with: "Jl. Lorem No. 99"
	    select "tempat tinggal", from: "tender_intent"
	    select "rumah tunggal", from: "tender_tangible"
	    choose "Ya"
	    click_button "Simpan"
	  end
	    
	  it { should have_content('Proposal berhasil dibuat') }

	  context "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: "Rp 500.000.000") }
	    it { should have_css('#tender-client', text: user.name) }
	    it { should have_css('#tender-contributed', text: "Rp 0") }
	  end
	end

	context "creating a musyarakah tender", js: true do
	  before do
	    visit user_root_path
	    click_link("", href: '#portlet_tab1')
	    click_link "Ajukan Musyarakah"
	    fill_in "tender_target", with: 400000000
	    fill_in "tender_price", with: 500000000
	    fill_in "tender_address", with: "Jl. Lorem No. 99"
	    select "tempat tinggal", from: "tender_intent"
	    select "rumah tunggal", from: "tender_tangible"
	    select "pembelian", from: "tender_use_case"
	    choose "Ya"
	    click_button "Simpan"
	  end
	    
	  it { should have_content('Proposal berhasil dibuat') }

	  context "should have correct information on tender show page" do
	    it { should have_css('#tender-target', text: "Rp 400.000.000") }
	    it { should have_css('#tender-price', text: "Rp 500.000.000") }
	  end
	end	
  end

  describe "when there is a murabahah tender" do
	let!(:tender) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user) }

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
	    it { should have_css('#tender-price', text: "Rp 400.000.000") }
	  end
	end
  end

end