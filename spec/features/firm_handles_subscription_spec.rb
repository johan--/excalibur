require 'rails_helper'
# require 'phantomjs'

feature "FirmHandlesSubscription", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm) }
  let!(:sub_1) { FactoryGirl.create(:active_1_mo, firm: firm_1) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }
  let!(:book_1) { FactoryGirl.create(:user_booking, court: venue_1.courts.first) }
  let!(:book_2) { FactoryGirl.create(:user_booking, court: venue_1.courts.second) }
  let!(:book_3) { FactoryGirl.create(:user_booking, court: venue_1.courts.last) }
  let!(:book_4) { FactoryGirl.create(:user_booking, court: venue_1.courts.third) }

  before do 
	books = [book_1, book_2, book_3, book_4]
	books.each{ |book| book.transition_to!(:confirmed) }	
  	sign_in user 
  	visit biz_management_path
  	click_link "Ke Halaman Langganan"
  end

  describe "the subscription page of a firm"  do
  	it { should have_title("Akun Berlangganan") }
  	it { should have_content("Aktif") }
  	it { should have_css("#next-deadline", text: sub_1.end_date) }
  	it { should have_css('#next-bill', text: 'Rp 40000') }
  end

  describe "paying the bill", js: true do
  	before do	  	
  		Timecop.travel(30.days.from_now) 
  		click_link "Catat Pembayaran"
  		fill_in "payment_pay_code", with: "fkafoffagag"
  		# fill_in "Tanggal Pembayaran", with: 1.day.ago.to_date
  		# page.execute_script("$('.show-datepicker').datepicker('setDate', '#{Date.today}')")
  		fill_in "payment_pay_time", with: "15:00"
  		fill_in "payment_total", with: 40000
  		page.execute_script("$('#payment_pay_day').val('03/07/2015')")
  		click_button "Simpan"
  	end
    after { Timecop.return }
    
      it { should have_content("Pembayaran berhasil dicatat, tunggu konfirmasi") }
      it { should have_css('.list-group-item', text: "fkafoffagag") }
      it { should have_css('.list-group-item', text: "03-07-2015") }
      it { should have_no_css("#next-deadline", text: Date.today.strftime("%d-%m-%Y")) }
      it { should have_content('Rp 0') }      

  end

  # describe "missing the deadline of payment" do
  #   before do     
  #     Timecop.travel(37.days.from_now) 
  #     visit biz_root_path
  #   end

  #   it { should have_title("Langganan Tidak Berlaku") }

  #   after do
  #     Timecop.return
  #   end          
  # end


end
