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

  	describe "making the reservation" do
  		before do
  			click_link "Lihat"
  			
  		end
  	end
  end

end
