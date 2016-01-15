require 'rails_helper'

describe TendersController do
  let!(:house) { FactoryGirl.create(:house) }
  
  login_user

  describe "GET show" do
  	let!(:tender) { FactoryGirl.create(:tender, :murabaha, 
  											:house_purchase) }

    context "when passed in with current user" do
      it 'shows attributes of a reservations' do
        get :show, id: tender.id

        expect(response).to be_success
      end
    end
  end

  describe "POST 'create' " do
    context "valid tender" do
      before(:each) {
        post :create, :tender => { 
          	house_id: house.id, user_id: subject.current_user.id,
        	annum: 10, seed_capital: 20,
        	aqad: 'murabaha', category: 'house purchase' }
      }

      it "has an authenticated user" do
    	expect(subject.current_user).to_not eq(nil)
      end

      it "adds the tender" do
        expect(Tender.count).to eq 1
      end

      it "does not render to new page" do
    	expect(response.status).to eq(302)
      end
    end
  end

  describe "PUT 'update' " do
  	let!(:other_house) { FactoryGirl.create(:house) }
  	let!(:tender) { FactoryGirl.create(:tender, :murabaha, 
  								:house_purchase) }
  	context "valid update" do
  	  before(:each) { put :update, { id: tender.id, :tender => {
          	house_id: other_house.id, seed_capital: 30 } } 
      }

  	  it "updates successfully and redirect" do
  	    expect(response.status).to eq(302)
  	  end

  	  it "updates the house of tender" do
  	  	result = Tender.first.house_id

  	  	expect(result).to eq other_house.id
  	  end

  	  it "updates the seed capital of tender" do
  	  	result = Tender.first.seed_capital

  	  	expect(result).to eq "30"
  	  end  	  
  	end
  end

  # describe "Delete #destroy" do
  #   context "when valid" do
  #     it 'DELETE /listings/:id.json' do
  #       delete :destroy, { id: bid_1.id, format: :json }

  #   	expect(response.status).to eq(204)
  #     end
  #   end
  # end

end