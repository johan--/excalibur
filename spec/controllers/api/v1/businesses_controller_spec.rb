require 'rails_helper'

describe API::V1::BusinessesController do
  let!(:owner) { FactoryGirl.create(:entrepreneur) }
  let!(:biz_1) { FactoryGirl.create(:business, starter_email: owner.email) }
  let!(:biz_2) { FactoryGirl.create(:business, :with_starter) }

  describe "GET #index" do   
  	let!(:investor) { FactoryGirl.create(:investor) }

    context "when accessed by authorized_user" do
      before(:each) do 
        api_authorization_header(owner.auth_token) 
        get :index, format: :json
      end

      it 'sends a list of businesses' do
        expect(response).to be_success
      end
    end

    # context "when accessed by unauthorized_user" do
    #   before(:each) do 
    #     api_authorization_header(investor.auth_token) 
    #     get :index, format: :json
    #   end

    #   it 'shows error' do
    #     expect(response.status).to eq(401)
    #   end
    # end    
  end

  describe "GET show" do
    context "when passed in with user that has access" do
      before(:each) do 
        api_authorization_header(owner.auth_token) 
         get :show, { id: biz_1.id, format: :json }
      end

      it 'shows success message' do
        expect(response).to be_success
      end
    end  
  end

  describe "POST 'create' " do
  	let!(:investor) { FactoryGirl.create(:entrepreneur) }

    context "valid params" do
      before(:each) do 
        api_authorization_header(owner.auth_token) 
      end

      it "returns a successful json string with success message" do
        post :create, { :business => { 
          name: "PT Futsal Lorem", anno: 2015,
          about: "Lorem ipsum dolor cassus", founding_size: 4,
          starter_email: owner.email }, format: :json }

        expect(response.status).to eq(201)
      end
    end

    # context "invalid access" do
    #   before(:each) do 
    #     api_authorization_header(investor.auth_token) 
    #   end

    #   it "returns an unsuccessful json string with failure message" do
    #     post :create, { :business => { 
    #       name: "PT Futsal Lorem", anno: 2015,
    #       about: "Lorem ipsum dolor cassus", founding_size: 4 }, 
    #       format: :json }

    #     expect(response.status).to eq(401)
    #   end
    # end
  end

  describe "PUT 'update' " do
  	context "valid update" do
      before(:each) do 
        api_authorization_header(owner.auth_token) 
      end
      
      it "updates successfully" do
        put :update, { id: biz_1.id, :business => { 
          name: biz_1.name, anno: 2016, about: "Lorem blablabla dolor", 
          founding_size: 6, starter_email: owner.email }, format: :json }       
  	    	
  	    expect(response.status).to eq(200)
  	  end
  	end

  end

end