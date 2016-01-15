require 'rails_helper'

describe BidsController do
  let!(:tender) { FactoryGirl.create(:tender, :murabaha, 
                        :house_purchase) }
  login_user

  # describe "GET show" do
  #   # let!(:bid) { FactoryGirl.create(:bid) }
  #   context "when passed in with current user" do
  #     it 'shows attributes of a reservations' do
  #       get :show, id: tender.id

  #       expect(response).to be_success
  #     end
  #   end
  # end

  describe "POST 'create' " do
    context "valid bid" do
      before(:each) {
        post :create, tender_id: tender.id, :bid => { 
          volume: 1000, message: 'lorem ipsum dolor' }
      }

      it "creates the bid" do
    	  expect(Bid.count).to eq 1
      end

      it "submits the right volume" do
        expect(Bid.first.volume).to eq 1000
      end

      it "relates to the tender" do
        expect(tender.bids.count).to eq 1
      end

      it "updates the tender" do
        result = Bid.first.tender.state

        expect(result).to eq 'closed'
      end

      it "relates to the bidder which is current_user" do
        expect(tender.bids.first.bidder).to eq subject.current_user
      end

      it "does not render to new page" do
    	  expect(response.status).to eq(302)
      end
    end
  end

  describe "PUT 'update' " do
    let!(:bid) { FactoryGirl.create(:bid, tender: tender) }
    # let!(:bid) { FactoryGirl.create(:bid, :for_purchase_murabaha) }

  	context "valid update" do
  	  before(:each) { 
        patch :update, { :bid => { volume: 500 }, 
          tender_id: tender.id, id: bid.id 
        }
      }

  	  it "updates successfully and redirect" do
  	    expect(response.status).to eq(302)
  	  end

  	  # it "updates the volume" do
  	  # 	result = bid.volume

  	  # 	expect(result).to eq 500
  	  # end

     #  it "updates the tender" do
     #    result = bid.tender.state

     #    expect(result).to eq 'open'
     #  end      
  	end
  end

  describe "Delete #destroy" do
    let!(:bid) { FactoryGirl.create(:bid, tender: tender) }

    context "when valid" do
      before(:each) { delete :destroy, tender_id: tender.id, id: bid.id  }

      it 'does not really delete the object' do
        expect(Bid.with_deleted.count).to eq 1
      end

      it 'is a success and redirect' do
    	  expect(response.status).to eq(302)
      end
    end
  end

end