require 'rails_helper'

feature "AdminListsHouses", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  
  before(:each) { sign_in admin }

  describe "go into admin house index then adds house" do
  	before do
  	  click_link "Houses"
  	  click_link "Tambah Rumah"
	    fill_in "house_price", with: 300000000
	    select "rumah", from: "house_category"
	    select "available", from: "house_state"
	    # fill_in "house_title", with: "rumah 1 kompleks pangkalan jati"
	    fill_in "house_address", with: "Jl. Lorem No. 99"
	    fill_in "house_city", with: "Jakarta Selatan"
	    fill_in "house_bedrooms", with: 3
	    fill_in "house_bathrooms", with: 1
	    fill_in "house_level", with: 1
	    fill_in "house_garages", with: 1
	    select "True", from: "house_greenery"
	    fill_in "house_lot_size", with: 100
	    fill_in "house_property_size", with: 90
	    fill_in "house_anno", with: 2015
	    click_button "Simpan"
  	end

  	it { should have_content('Rumah berhasil didaftarkan') }

	context "should have correct information on tender show page" do
	  it { should have_css('#house-price', text: "Rp 300000000,00") }
	end

  end

  describe "editing the house" do
  	let!(:house) { FactoryGirl.create(:house) }

    before do
      click_link "Houses"
	  click_link("Proses")
	  # click_link("", href: edit_admin_house_path(house))
	  fill_in "house_price", with: 140000000
	  select "for sale", from: "house_state"
	  click_button "Simpan"
	end

  	it { should have_content('Rumah berhasil dikoreksi') }

	context "should have correct information on tender show page" do
	  it { should have_css('#house-state', text: "for sale") }
	  it { should have_css('#house-price', text: "Rp 140000000,00") }
	end
  end

end
