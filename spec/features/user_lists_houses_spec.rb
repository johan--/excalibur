require 'rails_helper'

feature "UserListsHouses", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  
  before(:each) { sign_in user }

  describe "go into root path then start the form wizard" do
  	before do
  	  	click_link "Daftarkan Rumah"
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

  	it { should have_content('Terima kasih, rumah sudah didaftarkan') }

	# context "should have correct information on tender show page" do
	#   it { should have_css('#house-price', text: "Rp 300000000,00") }
	# end
  end

 #  describe "editing the house" do
 #  	let!(:house) { FactoryGirl.create(:house) }

 #    before do
 #      click_link "Houses"
	#   click_link("Proses")
	#   # click_link("", href: edit_admin_house_path(house))
	#   fill_in "house_price", with: 140000000
	#   select "for sale", from: "house_state"
	#   click_button "Simpan"
	# end

 #  	it { should have_content('Rumah berhasil dikoreksi') }

	# context "should have correct information on tender show page" do
	#   it { should have_css('#house-state', text: "for sale") }
	#   it { should have_css('#house-price', text: "Rp 140000000,00") }
	# end
 #  end

end
