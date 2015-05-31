require 'rails_helper'

feature "UserMakesReservations", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_2) { FactoryGirl.create(:user) }
  let!(:venue_1) { FactoryGirl.create(:capital_venue) }
  let!(:venue_2) { FactoryGirl.create(:satellite_venue) }
  let!(:res_2) { FactoryGirl.create(:direct_booking, 
                    court: venue_1.courts.first, booker: user_2) }
  

  describe "in home tab" do
    before { sign_in user }
  	
    describe "the venue options" do
  		it { should have_content(venue_1.name) }
      it { should have_content(venue_2.name) }
  	end

  	describe "filtering the reservation" do
  		before do
  			click_link "Lihat", href: venue_path(venue_1)
        select "2015", :from => 'q[date_reserved_eq(1i)]'
        select "May", :from => 'q[date_reserved_eq(2i)]'
        select "10", :from => 'q[date_reserved_eq(3i)]'
        check "show-start-filter"
        select "15", :from => 'q[start_gteq(4i)]'
        select "17", :from => 'q[start_lteq(4i)]'
        click_button "Cari"
  		end

      it { should_not have_content("0 pesanan terdaftar pada May 10, 2015, 
        antara jam 15:00-17:00") }

      describe "making the reservation" do
        before do
          fill_in "reservation_duration", with: 2
          click_button "Pesan"
        end
        
        it { should have_content("Pemesanan berhasil dilakukan") }
        it { should_not have_link("Konfirmasi") }
      end
  	end
  end

  describe "confirming reservation" do
    before do 
      sign_in user_2 
      click_link "Konfirmasi"
    end

    it { should have_content("Success") }
  end

end
