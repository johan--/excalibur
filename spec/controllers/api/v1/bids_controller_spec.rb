require 'rails_helper'

describe API::V1::BidsController do
  let!(:biz) { FactoryGirl.create(:business, :with_starter) }
  let!(:tender_1) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }
  let!(:user) { FactoryGirl.create(:investor) }
  let!(:bid_1) { FactoryGirl.create(:bid, bidder: user, tender: tender_1) }
  let!(:tender_2) { FactoryGirl.create(:retail, :murabahah, tenderable: biz) }
  
  before(:each) do 
  	api_authorization_header(user.auth_token) 
  end

  describe "GET #index" do
    context "when valid" do
      it 'sends a list of bids made by current user' do
        get :index, format: :json

        expect(response).to be_success
      end
    end
  end

  describe "GET show" do
    context "when passed in with current user" do
      it 'shows attributes of a reservations' do
        get :show, { id: bid_1.id, format: :json }

        expect(response).to be_success
      end
    end
  end

  describe "POST 'create' " do
    context "valid bid" do
      it "returns a successful json string with success message" do
        post :create, { :bid => { 
          	contribution: 2000000, bidder_type: user.class.name,
        	bidder_id: user.id, tender_id: tender_2.id }, 
        	format: :json }

        expect(response.status).to eq(201)
      end
    end
  end

  describe "PUT 'update' " do
  	context "valid update" do
  	  it "updates successfully" do
  	    put :update, { id: bid_1.id, :bid => {
          	contribution: 1000000, bidder_type: user.class.name,
        	bidder_id: user.id, tender_id: tender_2.id },
        	format: :json }

  	    expect(response.status).to eq(200)
  	  end
  	end
  end

  describe "Delete #destroy" do
    context "when valid" do
      it 'DELETE /listings/:id.json' do
        delete :destroy, { id: bid_1.id, format: :json }

    	expect(response.status).to eq(204)
      end
    end
  end

end