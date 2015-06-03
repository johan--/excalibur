require 'rails_helper'

feature "VenueGetsReservations", :type => :feature do
  subject { page }

  let!(:user) { FactoryGirl.create(:manager) }
  let!(:firm_1) { FactoryGirl.create(:firm) }
  let!(:as_owner) { FactoryGirl.create(:active_manager, 
  									user: user, rosterable: firm_1) }  
  let!(:venue_1) { FactoryGirl.create(:capital_venue, firm: firm_1) }

  before { sign_in user }

  describe "manager home" do
  	it { should have_content(firm_1.name) }
  end

end
