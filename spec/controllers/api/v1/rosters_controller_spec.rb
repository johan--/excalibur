# require 'rails_helper'

# describe API::V1::RostersController do
#   let!(:user) { FactoryGirl.create(:entrepreneur) }
#   let!(:biz_2) { FactoryGirl.create(:business, :with_starter) }
#   let!(:starter) { biz_2.rosters.first }

#   before(:each) do 
#     api_authorization_header(user.auth_token) 
#   end

#   describe "GET show" do
#     context "when passed in with current user" do
#       it 'shows attributes of a venues' do
#         get :show, { id: starter.id, format: :json }

#         expect(response).to be_success
#       end
#     end
#   end

#   describe "POST 'create' " do
#     context "valid params" do
#       it "returns a successful json string with success message" do
#         post :create, { :roster => { 
# 				team_id: biz_2.team.id, rosterable_type: user.class.name, 
# 				rosterable_id: user.id, role: 1}, 
# 				format: :json }

#         expect(response.status).to eq(201)
#       end
#     end
#   end

#   describe "PUT 'update' " do
#     context "valid params" do
#       it "returns a successful json string with success message" do
#         post :update, { id: starter.id, :roster => { 
# 				team_id: biz_2.team.id, rosterable_type: user.class.name, 
# 				rosterable_id: user.id, role: 2}, 
# 				format: :json }

#         expect(response.status).to eq(200)
#       end
#     end
#   end


#   describe "Delete #destroy" do
#     context "when valid" do
#       it 'DELETE /rosters/:id.json' do
#         delete :destroy, { id: starter.id, format: :json }

#     	  expect(response.status).to eq(204)
#       end
#     end
#   end

# end