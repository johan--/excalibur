# require 'rails_helper'

# describe API::V1::UsersController do
#   let!(:user) { FactoryGirl.create(:entrepreneur) }

#   before(:each) do 
#   	api_authorization_header(user.auth_token)
#   end
  
#   it "retrieves user from GET #show" do
#     get :show, { id: user.id, format: :json }
		
# 		expect(response.status).to eq(200)
#   end

#   describe "POST #create" do
#     context "when is successfully created" do
#     	it "renders the right response status" do
#       	post :create, { :user => { 
#           email: "momo@example.com", password: user.password,
#           password_confirmation: user.password_confirmation,
#           name: "momo user" }, 
#           format: :json }

#       	expect(response.status).to eq(201)
#       end
#     end

#     context "when is successfully created" do
#     	it "renders the right response status" do
#       	post :create, { :user => { 
#           email: user.email, password: user.password,
#           password_confirmation: user.password_confirmation,
#           name: user.name },
#           format: :json }        

#       	expect(response.status).to eq(422)
#       end
#     end
#   end

#   describe "PUT #update" do
#     context "when is successfully updated" do
#     	it "renders the right response status" do
#       	put :update, { id: user.id, :user => { 
#           password: "qweqweqwe", password_confirmation: "qweqweqwe",
#           current_password: user.password }, format: :json }

#       	expect(response.status).to eq(200)
#       end
#     end

#     # context "when is successfully updated" do
#     # 	it "renders the right response status" do
#     #   	post api_v1_users_path, { 
#     #     :user => { email: user.email, password: user.password,
#     #     password_confirmation: user.password_confirmation,
#     #     name: user.name } }.to_json, 
#     #     {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

#     #   	expect(response.status).to eq(422)
#     #   end
#     # end
#   end

# end