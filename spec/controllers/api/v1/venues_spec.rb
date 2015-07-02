require 'rails_helper'

describe API::V1::VenuesController do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  # let!(:book_2) { FactoryGirl.create(:user_booking, court: venue.courts.second) }
  # let!(:book_3) { FactoryGirl.create(:paid_booking, court: venue.courts.third) }

  before(:each) do 
  	api_authorization_header(user.auth_token) 
  end

  describe "GET #index" do
    context "when valid" do
      it 'sends a list of venues' do
        get :index, format: :json

        expect(response).to be_success
      end
    end
  end

  describe "GET show" do
    context "when passed in with current user" do
      it 'shows attributes of a venues' do
        get :show, { id: venue.id, format: :json }

        expect(response).to be_success
      end
    end
  end

  describe "POST 'create' " do
  	let!(:firm_2) { FactoryGirl.create(:firm_with_team, :with_subscription) }

    context "valid venue" do
      it "returns a successful json string with success message" do
        post :create, { :venue => { 
          name: "Bekasi", address: "Jl. Satelit No. 90",
        	phone: "011111111", province: "Banten", city: "Bekasi",
        	firm_id: firm_2.id }, format: :json }

        expect(response.status).to eq(201)
        # expect(response.message).to eq("Reservasi berhasil dibuat")
      end
    end

  end

  describe "PUT 'update' " do
    let!(:firm_2) { FactoryGirl.create(:firm_with_team, :with_subscription) }
  	context "valid update" do
  	  it "updates successfully" do
  	    put :update, { id: venue.id, 
          :venue => { name: "Bekasi", address: "Jl. Satelit No. 90",
          province: "Banten", city: "Bekasi", firm_id: firm_2.id, 
          phone: "0222222222222" }, format: :json }

  	    expect(response.status).to eq(200)
  	  end
  	end

  end

  # describe "Delete #destroy" do
  #   context "when valid" do
  #     it 'DELETE /venues/:id.json' do
  #       delete :destroy, { id: venue.id, format: :json }

  #   	  expect(response.status).to eq(200)
  #     end
  #   end
  # end

end