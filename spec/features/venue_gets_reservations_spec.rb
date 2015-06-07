require 'rails_helper'

feature "VenueGetsReservations", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm, :with_subscription) }
  let!(:as_manager) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }
  let!(:book_1) { FactoryGirl.create(:user_booking, court: venue_1.courts.first) }
  let!(:book_2) { FactoryGirl.create(:user_booking, court: venue_1.courts.second) }
  # let!(:book_3) { FactoryGirl.create(:user_booking, court: venue_1.courts.third) }
  # let!(:book_4) { FactoryGirl.create(:user_booking, court: venue_1.courts.last) }

  before { sign_in user }

  describe "biz home" do
    it { should have_title("Home | #{firm_1.name}") }
    it { should have_content(firm_1.name) }
  end

  describe "an upcoming reservation" do
    describe "the calendar" do
      it { should have_css(".date-group", text: book_1.date_reserved) }
      # it { should have_css(".count", text: 3) }
    end

    describe "the ticket" do
      it { should have_css(".ticket", text: book_1.start) }
      it { should have_css(".ticket", text: book_1.finish) }
      it { should have_css(".ticket", text: book_1.court.name) }
    end
  end

end
