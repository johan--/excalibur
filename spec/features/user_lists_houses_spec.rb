require 'rails_helper'

feature "UserListsHouses", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) { sign_in user }

  describe "go into root path then start the form wizard and complete it" do
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

		attach_file('house_photos', file_upload_fixture)
		click_button "Kirim"

	    fill_in "Harga", with: 300000000
		select "no", from: "Dijual"
		select "no", from: "Kosong?"
	    fill_in "Tahun Dibangun", with: 2015
	    fill_in "Tenor Hutang", with: 36
	    fill_in "Sisa Hutang", with: 750000000
	    click_button "Lanjutkan"
  	end

  	it { should have_content('Terima kasih, data sudah lengkap') }
  end


  describe "start the form wizard but not complete it" do
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

  	it { should have_content('Unggah Display Picture') }
  end
end