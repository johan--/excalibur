# require 'rails_helper'

# describe API::V1::TendersController do
#   let!(:user) { FactoryGirl.create(:entrepreneur) }
#   let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }
#   let!(:tender_1) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }

#   before(:each) do 
#   	api_authorization_header(user.auth_token) 
#   end

#   describe "GET #index" do
#   	let!(:biz_2) { FactoryGirl.create(:business, :with_starter) }
#   	let!(:tender_2) { FactoryGirl.create(:retail, :musharakah, tenderable: biz_2) }
#   	let!(:tender_3) { FactoryGirl.create(:retail, :musharakah, tenderable: biz_2) }

#     context "when valid" do
#       it 'sends a list of tenders' do
#         get :index, format: :json

#         expect(response).to be_success
#       end
#     end
#   end

#   describe "GET show" do
#     context "when passed in with current user" do
#       it 'shows attributes of a reservations' do
#         get :show, { id: tender_1.id, format: :json }

#         expect(response).to be_success
#       end
#     end
#   end

#   describe "POST 'create' " do
#     context "valid tender" do
#       it "returns a successful json string with success message" do
#         post :create, { :tender => { 
#   	  		category: "Bisnis", aqad: "musharakah", target: 10000000,
#   			tenderable_type: biz.class.name, tenderable_id: biz.id, 
#   			summary: "Lorem ipsum dolor cassus", intent_type: "Ekspansi",
#   			intent_assets: ['Kendaraan'] }, format: :json }

#         expect(response.status).to eq(201)
#       end
#     end

#   end

#   describe "PUT 'update' " do
#   	context "valid update" do
#   	  it "updates successfully" do
#   	    put :update, { id: tender_1.id, :tender => {
#             category: "Bisnis", aqad: "musharakah", target: 8000000,
#   			tenderable_type: biz.class.name, tenderable_id: biz.id, 
#   			summary: "Lorem ipsum dolor cassus", intent_type: "Ekspansi",
#   			intent_assets: ['Kendaraan'] }, format: :json }

#   	    expect(response.status).to eq(200)
#   	  end
#   	end
#   end

#   describe "Delete #destroy" do
#     context "when valid" do
#       it 'DELETE /listings/:id.json' do
#         delete :destroy, { id: tender_1.id, format: :json }

#     	expect(Tender.where(id: tender_1.id)).to be_empty
#     	expect(response.status).to eq(204)
#       end
#     end
#   end

# end