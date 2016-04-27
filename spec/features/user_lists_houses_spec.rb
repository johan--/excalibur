require 'rails_helper'

feature "UserListsHouses", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) { sign_in user }

  describe "only list the house" do
  	before do
  	  	click_link "Daftarkan Rumah", match: :first
	    fill_in "Alamat", with: "Lorem No. 99"
	    fill_in "Kota", with: "Jakarta Selatan"
	    fill_in "Provinsi", with: "DKI Jakarta"
	    click_button "Lanjutkan"

	    select "rumah", from: "house_category"
	    fill_in "house_bedrooms", with: 3
	    fill_in "house_bathrooms", with: 1
	    fill_in "house_level", with: 1
	    fill_in "house_garages", with: 1
	    fill_in "house_lot_size", with: 100
	    fill_in "house_property_size", with: 90
	    fill_in "house_description", with: "lorem ipsum dolor is a typesetting defaults for dummy text"
		click_button "Lanjutkan"

	    fill_in "Harga", with: 300000000
		select "no", from: "Dijual"
		select "no", from: "Kosong?"
	    fill_in "Tahun Dibangun", with: 2015
	    select "no", from: "Ada Sisa KPR"
	    click_button "Lanjutkan"
		# attach_file('house_photos', file_upload_fixture)
	end
		
	context "then finish the wizard" do
		before { click_button "Lanjutkan" }
		
		it { should have_content('Terima kasih, data telah disimpan') }
	end


  	context "then create proposal straight away" do
		before do 
			check 'house_proposed'
			click_button "Lanjutkan"

			fill_in "tender_annum", with: 10
			fill_in "tender_seed_capital", with: 20
			click_button "Ajukan"
		end
		it { should have_content('Proposal berhasil dibuat') }
  	end

  	
  end


  describe "Not finishing the form" do
  	before do
  	  	click_link "Daftarkan Rumah", match: :first
	    fill_in "Alamat", with: "Lorem No. 99"
	    fill_in "Kota", with: "Jakarta Selatan"
	    fill_in "Provinsi", with: "DKI Jakarta"
	    click_button "Lanjutkan"

	    select "rumah", from: "house_category"
	    fill_in "house_bedrooms", with: 3
	    fill_in "house_bathrooms", with: 1
	    fill_in "house_level", with: 1
	    fill_in "house_garages", with: 1
	    fill_in "house_lot_size", with: 100
	    fill_in "house_property_size", with: 90
		click_button "Lanjutkan"
		
		click_link "Home"
		click_link("Edit")
  	end

  	it { should_not have_content('Unggah Display Picture') }
  end
end