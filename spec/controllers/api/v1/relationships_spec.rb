require 'rails_helper'

# describe API::V1::RelationshipsController do
#   let!(:user) { FactoryGirl.create(:player) }
#   let!(:user_2) { FactoryGirl.create(:player) }
#   let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
#   let!(:following) { FactoryGirl.create(:follow, follower: user, 
#                                               followed: user_2) }

#   before(:each) do 
#     api_authorization_header(user.auth_token)
#   end

#   describe "GET #index" do
#     context "when pass in with current user" do
      
#       it 'sends a list of relationships' do
#         get :index, format: :json

#         expect(response).to be_success # test for the 200 status-code
#         # json = JSON.parse(response.body)
#         # expect(json['relationships'].length).to eq(1) 
#       end

#     end
#   end

#   describe "GET #show" do
#     context "when passed in a relationship id" do
#       it 'shows attributes of a relationships' do
#         get :show, { id: following.id, format: :json }

#         expect(response).to be_success            
#       end
#     end
#   end

#   describe "POST 'create' " do
#     context "valid relationship" do
#       it "returns a successful json string with success message" do
#         post :create, {
#         	:relationship => { follower_id: user.id,
#         	followed_type: venue.class.name, followed_id: venue.id}, 
#           format: :json }

#         expect(response.status).to eq(201)
#       end
#     end

#     # context "invalid relationship" do
#     #   it "returns an error response" do
#     #     post api_v1_relationships_path, {
#     #     	:relationship => { date_reserved: book_1.date_reserved,
#     #     	start: book_1.start, duration: book_1.duration, 
#     #     	court_id: book_1.court_id, charge: "0" } }.to_json, 
#     #     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

#     #     expect(response.status).to eq(422)
#     #   end
#     # end
#   end

#   describe "POST #destroy " do
#     context "valid request" do
#       it 'deletes successfully' do
#         delete :destroy, { id: following.id, format: :json }

#     	  expect(response.status).to eq(200)
#       end
#     end
#   end

# end