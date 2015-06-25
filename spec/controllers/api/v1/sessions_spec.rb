require 'rails_helper'

describe API::V1::SessionsController do
  let!(:user) { FactoryGirl.create(:player) }

  describe "POST #create" do
    context "when the credentials are correct" do
      before(:each) do
        post :create, { 
          :session => { email: user.email, password: user.password }, 
                        format: :json }
      end

      it "returns the user record corresponding to the given credentials" do
        # post :create, { 
        #   :session => { email: user.email, password: user.password }, 
        #                 format: :json }
        
        expect(response.status).to eq(200)
      end
    end

    # context "when the credentials are incorrect" do
    #   before(:each) do
    #     credentials = { email: user.email, password: "invalidpassword" }
    #     post :create, { session: credentials }
    #   end

    #   # it "returns a json with an error" do
    #   #   expect(json_response[:errors]).to eql "Invalid email or password"
    #   # end

    #   it { should respond_with 422 }
    # end
  end

  describe "DELETE #destroy" do
    before { api_authorization_header(user.auth_token) }
    
    it "expires old token and create a new token" do
      delete :destroy, { id: user.auth_token, format: :json }

      expect(response.status).to eq(204)
    end
  end

end