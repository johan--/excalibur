require 'rails_helper'

feature "FirmHandlesVenues", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm, :with_subscription) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  

  before do 
  	sign_in user 
  end

  describe "the prompt panel when there is no venue" do
  	it { should have_content("Kamu belum mendaftarkan arena futsal") }
  	it { should have_css('#no-venue', text: 'Daftarkan Arena') }
  end


  describe "creating a venue" do
  	before do
  	  click_link "Daftarkan Arena"
	  fill_in("venue[name]", with: "Go Futsal")
	  select "DKI Jakarta", from: "Provinsi"
	  fill_in("venue[city]", with: "Jakarta Selatan")
	  fill_in("venue[address]", with: "Jl. Blabla No. 99")
	  fill_in("venue[phone]", with: "123456789")

		first_nested_fields = all('.nested-fields').first
		 
		within(first_nested_fields) do
		  fill_in "Nama Lapangan", with: "Lapangan 1"
		  fill_in "Tarif per Jam", with: 100000
		  select "Vinyl", from: "Jenis"
		end	  

	  click_button  "Simpan" 		
  	end
	it { should have_content("Arena berhasil didaftarkan") }
	it { should have_no_css('#no-venue', text: 'Daftarkan Arena') }
	it { should have_content("Go Futsal") }
  end

  describe "editing a venue" do
  	let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }

  	before do
  		visit biz_root_path
  		click_link "Edit", href: edit_biz_venue_path(venue_1)
		
		first_nested_fields = all('.nested-fields').first
		within(first_nested_fields) do
		  fill_in "Tarif per Jam", with: 300000
		end
		click_button  "Simpan"
  	end
	
	it { should have_content("Arena berhasil dikoreksi") }
  	
  	describe "clicking to show modal and changes made" do
  		before { visit biz_venue_path(venue_1) }

  		it { should have_no_css('#avg_price', text: "Rp 100000") }
  	end
  end

end
