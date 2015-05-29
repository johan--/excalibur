require 'rails_helper'

feature "UserMakesReservations", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:venue_1) { FactoryGirl.create(:capital_venue) }
  let!(:venue_2) { FactoryGirl.create(:satellite_venue) }

  before { sign_in user }

  describe "in home tab" do

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

      it { should have_content("0 pesanan terdaftar pada May 10, 2015, 
        antara jam 15:00-17:00") }

      describe "making the reservation" do
        before do
          fill_in "reservation_duration", with: 2
          click_button "Pesan"
        end
        
        it { should have_content("Pemesanan berhasil dilakukan") }
      end
  	end

  end

end
