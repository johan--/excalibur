require 'rails_helper'

feature "UserMakesReservations", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:player) }
  let!(:user_2) { FactoryGirl.create(:player) }
  let!(:venue_1) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:venue_2) { FactoryGirl.create(:satellite_venue) }
  let!(:res_2) { FactoryGirl.create(:direct_booking, 
                    court: venue_1.courts.first, booker: user_2) }
  

  describe "making reservation" do
    before do 
      sign_in user 
      click_link "Lihat Daftar Arena"
    end
  	
    describe "the venue options" do
  		it { should have_content(venue_1.name) }
      it { should have_content(venue_2.name) }
  	end

  	describe "filtering the reservations", js: true do
  		let!(:days_later) { 7.days.from_now.to_date }
      before do
  			click_link "Lihat", href: venue_path(venue_1)
        # select "2015", :from => 'q[date_reserved_eq]'
        page.execute_script("$('#q_date_reserved_eq').val('#{days_later}')")
        check "show-start-filter"
        select "15", :from => 'q[start_gteq(4i)]'
        select "17", :from => 'q[start_lteq(4i)]'
        click_button "Cari"
  		end

      it { should have_content("0 pesanan terdaftar pada #{days_later}, 
        antara jam 15:00-17:00") }

      describe "making the reservation" do
        before do
          page.execute_script("$('#reservation_date_reserved').val('#{days_later}')")
          select "15:00", :from => 'reservation[start]'
          select "2 Jam", :from => 'reservation[duration]'
          select venue_1.courts.first.name, :from => 'reservation[court_id]'
          click_button "Pesan"
        end
        
        it { should have_content("Pemesanan berhasil dilakukan") }
        it { should_not have_link("1 Pesanan Terdaftar") }
      end
  	end
  end

  describe "paying installment for reservation", js: true do
    let!(:now) { (res_2.date_reserved - 7.days).to_date }
    before do 
      sign_in user_2 
      click_button "Lihat Reservasi Saya"
      click_link "Bayar"
      # page.execute_script("$('.show-datepicker').datepicker('setDate', '#{Date.today}')")
      select res_2.code, from: 'installment_reservation_id'
      fill_in "installment_pay_time", with: "15:00"
      fill_in "installment_total", with: res_2.down_payment
      page.execute_script("$('#installment_pay_day').val('#{now}')")
      fill_in "installment_pay_code", with: "fkafoffagag"
      click_button "Simpan"      
    end

    it { should have_content("Pembayaran berhasil dicatat") }
  end

end
