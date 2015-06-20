require 'rails_helper'

describe "reservations API", :type => :request do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:book_2) { FactoryGirl.create(:user_booking, court: venue.courts.second) }
  let!(:book_3) { FactoryGirl.create(:paid_booking, court: venue.courts.third) }
  let!(:book_4) { FactoryGirl.create(:direct_booking, 
  	court: venue.courts.fourth, booker: user) }

  before do 
  	login user 
  end

  it 'sends a list of reservations' do
    get '/v1/reservations'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['reservations'].length).to eq(1) # check to make sure the right amount of reservations are returned
  end

  it 'shows attributes of a reservations' do
    get api_v1_reservation_path(book_4.id)

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
   
    # expect(json['start']).to eq(book_4.start) 
    # expect(json['finish']).to eq(book_4.finish) 
    expect(json['state']).to eq(book_4.state) 
  end

  describe "POST 'create' " do
  	let!(:venue_2) { FactoryGirl.create(:cap_venue_with_firm) }
  	let!(:court_5) { FactoryGirl.create(:court, venue: venue_2) }
  	let!(:book_1) { FactoryGirl.create(:user_booking, court: court_5) }
  	let(:api_request) { { format: :json } }

  	before :each do
  		api_request.merge attributes_for(:reservation)
  	end

    context "valid reservation" do
      it "returns a successful json string with success message" do
        	post api_v1_reservations_path( 
        	:reservation => { date_reserved: book_1.date_reserved,
        	start: book_1.start, duration: book_1.duration, 
        	court_id: court_5.id })

        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['success']).to eq("Reservasi berhasil dibuat")
      end
    end

    # context "incorrect email format" do
    #   it "returns an error if an incorrect email format is submitted" do
    #     post :create, { email: "new@studentexample" }
    #     parsed_response = JSON.parse(response.body)
    #     expect(response).to be_bad_request
    #     expect(parsed_response['invalid']).to eq("Invalid email format.")
    #   end
    # end
  end

end