require 'rails_helper'

describe API::V1::CourtsController do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:court_5) { FactoryGirl.create(:court, venue: venue) }
  # let!(:book_2) { FactoryGirl.create(:user_booking, court: venue.courts.second) }
  # let!(:book_3) { FactoryGirl.create(:paid_booking, court: venue.courts.third) }

  before(:each) do 
  	api_authorization_header(user.auth_token) 
  end

  describe "GET show" do
    context "when passed in with venue id" do
      it 'shows attributes of a court' do
        get :show, { id: court_5.id, format: :json }

        expect(response).to be_success
      end
    end
  end

  describe "POST 'create' " do
    context "valid court" do
      it "returns a successful json string with success message" do
        post :create, { :court => { 
          name: "Lapangan 6", price: "10000", unit: "Jam",
        	category: "1", venue_id: venue.id }, format: :json }

        expect(response.status).to eq(201)
      end
    end

  end

  describe "PUT 'update' " do
  	context "valid update" do
  	  it "updates successfully" do
  	    put :update, { id: court_5.id, 
          :court => { name: "Lapangan 6", unit: "Jam", category: "1", 
          venue_id: venue.id, price: "150000" }, format: :json }

  	    expect(response.status).to eq(200)
  	  end
  	end

  end

  # describe "Delete #destroy" do
  #   context "when valid" do
  #     it 'DELETE /courts/:id.json' do
  #       delete :destroy, { id: court.id, format: :json }
  #   	  expect(response.status).to eq(200)
  #     end
  #   end
  # end

end