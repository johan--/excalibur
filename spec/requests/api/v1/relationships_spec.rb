require 'rails_helper'

describe "relationships API", :type => :request do
  let!(:user) { FactoryGirl.create(:player) }
  let!(:user_2) { FactoryGirl.create(:player) }
  let!(:venue) { FactoryGirl.create(:cap_venue_with_firm) }
  let!(:following) { FactoryGirl.create(:follow, follower: user, 
                                              followed: user_2) }

  before do 
  	login user 
  end

  it 'sends a list of relationships' do
    get '/v1/relationships'

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['relationships'].length).to eq(1) # check to make sure the right amount of relationships are returned
  end

  it 'shows attributes of a relationships' do
    get api_v1_relationship_path(following.id)

    expect(response).to be_success            # test for the 200 status-code
  end

  describe "POST 'create' " do
    context "valid relationship" do
      it "returns a successful json string with success message" do
        post api_v1_relationships_path, {
        	:relationship => { follower_id: user.id,
        	followed_type: venue.class.name, followed_id: venue.id} 
          }.to_json, {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

        expect(response.status).to eq(201)
      end
    end

    # context "invalid relationship" do
    #   it "returns an error response" do
    #     post api_v1_relationships_path, {
    #     	:relationship => { date_reserved: book_1.date_reserved,
    #     	start: book_1.start, duration: book_1.duration, 
    #     	court_id: book_1.court_id, charge: "0" } }.to_json, 
    #     	{'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

    #     expect(response.status).to eq(422)
    #   end
    # end
  end

  it 'DELETE /listings/:id.json' do
    delete api_v1_relationship_path(following.id), { 
      :relationship => {id: following.id} }.to_json, 
      {'CONTENT_TYPE' => "application/json", 'ACCEPT' => 'application/json'}

	  expect(response.status).to eq(200)
  end

end