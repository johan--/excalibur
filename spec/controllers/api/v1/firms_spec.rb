require 'rails_helper'

describe API::V1::FirmsController do
  let!(:unauthorized_user) { FactoryGirl.create(:player) }
  let!(:authorized_user) { FactoryGirl.create(:manager) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }

  describe "GET #index" do   
    context "when accessed by authorized_user" do
      before(:each) do 
        api_authorization_header(authorized_user.auth_token) 
        get :index, format: :json
      end

      it 'sends a list of firms' do
        expect(response).to be_success
      end
    end

    context "when accessed by unauthorized_user" do
      before(:each) do 
        api_authorization_header(unauthorized_user.auth_token) 
        get :index, format: :json
      end

      it 'renders error message' do
        expect(response.status).to eq(401)
      end
    end    
  end

  describe "GET show" do
    let!(:firm) { FactoryGirl.create(:firm_with_team) }

    context "when passed in with user that has access" do
      before(:each) do 
        api_authorization_header(firm.rosters.first.user.auth_token) 
      end

      it 'shows attributes of a firms' do
        get :show, { id: firm.id, format: :json }

        expect(response).to be_success
      end
    end

    context "when passed in with user that has NO access" do
      before(:each) do 
        api_authorization_header(unauthorized_user.auth_token) 
      end

      it 'shows error message' do
        get :show, { id: firm.id, format: :json }

        expect(response.status).to eq(401)
      end
    end    
  end

  describe "POST 'create' " do
    context "valid access" do
      before(:each) do 
        api_authorization_header(authorized_user.auth_token) 
      end

      it "returns a successful json string with success message" do
        post :create, { :firm => { 
          name: "PT Futsal Lorem", address: "Jl. Satelit No. 90",
        	phone: "011111111", city: "Bekasi" }, format: :json }

        expect(response.status).to eq(201)
      end
    end

    context "invalid access" do
      before(:each) do 
        api_authorization_header(unauthorized_user.auth_token) 
      end

      it "returns a successful json string with success message" do
        post :create, { :firm => { 
          name: "PT Futsal Lorem", address: "Jl. Satelit No. 90",
          phone: "011111111", city: "Bekasi" }, format: :json }

        expect(response.status).to eq(401)
      end
    end
  end

  describe "PUT 'update' " do
    let!(:firm) { FactoryGirl.create(:firm_with_team) }
  	context "valid update" do
      before(:each) do 
        api_authorization_header(firm.rosters.first.user.auth_token) 
      end
      
      it "updates successfully" do
        put :update, { id: firm.id, :firm => { phone: "0222222222222" }, 
                        format: :json }        
  	    expect(response.status).to eq(200)
  	  end
  	end

  end

end