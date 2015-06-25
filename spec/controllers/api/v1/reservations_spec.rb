require 'rails_helper'

describe API::V1::ReservationsController do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:book_2) { FactoryGirl.create(:user_booking, court: venue.courts.second) }
  let!(:book_3) { FactoryGirl.create(:paid_booking, court: venue.courts.third) }
  let!(:book_4) { FactoryGirl.create(:direct_booking, 
  	court: venue.courts.fourth, booker: user) }

  before(:each) do 
  	api_authorization_header(user.auth_token) 
  end

  describe "GET #index" do
    before(:each) { get :index, format: :json }

    context "when valid" do

      it 'sends a list of reservations' do
        expect(response).to be_success
      end

      # it 'shows the right amount of reservations' do
      #   json = JSON.parse(response.body)
      #   expect(json['reservations'].length).to eq(1)
      # end

    end
  end

  describe "GET show" do
    context "when passed in with current user" do
      it 'shows attributes of a reservations' do
        get :show, { id: book_4.id, format: :json }

        expect(response).to be_success
        # json = JSON.parse(response.body)       
        # expect(json['state']).to eq(book_4.state) 
      end
    end
  end

  describe "POST 'create' " do
  	let!(:court_5) { FactoryGirl.create(:court, venue: venue) }
  	let!(:book_1) { FactoryGirl.create(:user_booking, court: court_5) }

    context "valid reservation" do
      it "returns a successful json string with success message" do
        post :create, { :reservation => { 
          date_reserved: book_1.date_reserved,
        	start: book_1.start, duration: book_1.duration, 
        	court_id: court_5.id }, format: :json }

        expect(response.status).to eq(201)
        # expect(response.message).to eq("Reservasi berhasil dibuat")
      end
    end

    # context "invalid reservation" do
    #   it "returns an error response" do
    #     post :create, {
    #     	:reservation => { date_reserved: book_1.date_reserved,
    #     	start: book_1.start, duration: book_1.duration, 
    #     	court_id: book_1.court_id, charge: "0" } }.to_json, 
    #     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

    #     expect(response.status).to eq(422)
    #   end
    # end
  end

  describe "PUT 'update' " do
  	context "valid update" do
  	  it "updates successfully" do
  	    put :update, { id: book_4.id, 
          :reservation => { start: "18:00" }, format: :json }

  	    expect(response.status).to eq(200)
  	    # expect(response.message).to eq("Reservasi berhasil dibuat")
  	  end
  	end

 #  	context "invalid update" do
	#   it "returns an error response" do
	#     put api_v1_reservation_path(book_4.id), {
	#     	:reservation => { booker_id: '50' } }.to_json, 
	#     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

	#     expect(response.status).to eq(422)
	#   end
	# end
  end

  describe "Delete #destroy" do
    context "when valid" do
      it 'DELETE /listings/:id.json' do
        delete :destroy, { id: book_4.id, format: :json }

    	expect(Reservation.where(id: book_4.id)).to be_empty
    	expect(response.status).to eq(200)
      end
    end
  end

end