require 'rails_helper'

describe API::V1::InstallmentsController do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:book_4) { FactoryGirl.create(:direct_booking, 
                    court: venue.courts.fourth, booker: user) }
  let!(:book_2) { FactoryGirl.create(:user_booking, court: venue.courts.second) }
  let!(:book_3) { FactoryGirl.create(:paid_booking, court: venue.courts.third) }

  before(:each) do 
  	api_authorization_header(user.auth_token) 
  end

  describe "GET show" do
    let!(:pay_1) { FactoryGirl.create(:installment, :with_booking, reservation: book_2) }
    context "when passed in with current user" do
      it 'shows attributes of a installments' do
        get :show, { id: pay_1.id, format: :json }

        expect(response).to be_success
      end
    end
  end

  describe "POST 'create' " do
    context "valid installment" do
      it "returns a successful json string with success message" do
        post :create, { :installment => { 
          pay_code: "kanfanfnoaonfoa",
        	pay_day: Date.today, pay_time: Time.now, 
        	reservation_id: book_2.id }, format: :json }

        expect(response.status).to eq(201)
      end
    end

    # context "invalid installment" do
    #   it "returns an error response" do
    #     post :create, {
    #     	:installment => { date_reserved: book_1.date_reserved,
    #     	start: book_1.start, duration: book_1.duration, 
    #     	court_id: book_1.court_id, charge: "0" } }.to_json, 
    #     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

    #     expect(response.status).to eq(422)
    #   end
    # end
  end

 #  describe "PUT 'update' " do
 #  	context "valid update" do
 #  	  it "updates successfully" do
 #  	    put :update, { id: book_4.id, 
 #          :installment => { start: "18:00" }, format: :json }

 #  	    expect(response.status).to eq(200)
 #  	    # expect(response.message).to eq("Reservasi berhasil dibuat")
 #  	  end
 #  	end

 # #  	context "invalid update" do
	# #   it "returns an error response" do
	# #     put api_v1_installment_path(book_4.id), {
	# #     	:installment => { booker_id: '50' } }.to_json, 
	# #     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

	# #     expect(response.status).to eq(422)
	# #   end
	# # end
 #  end

end