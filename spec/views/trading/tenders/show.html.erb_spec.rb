require 'rails_helper'

describe 'trading/tenders/show.html.erb', :type => :view do
  before(:each) do
    @user =  FactoryGirl.create(:user)
  end

  context 'as the starter' do
    before(:each) do
      @tender = FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: @user)
      view.stub(:current_user).and_return(@user)
      assign(:client, @user)
      assign(:tender, @tender)
      assign(:asset, @tender.tenderable)
      assign(:bids, @tender.bids)

      render
    end

    it 'displays the control options' do
      expect(rendered).to have_link 'Kelola Proposal', href: edit_tender_path(@tender)
    end

    it 'displays the edit bid options' do
      expect(rendered).to have_link 'Edit', href: edit_tender_bid_path(@tender, @tender.bids.first)
    end

    it 'displays its client' do
      expect(rendered).to have_selector('#client-name', text: @user.name.titleize)
    end

    it 'displays its asset proposed' do
      expect(rendered).to have_selector('#asset-address', text: @tender.tenderable.address)
    end
  end

  context 'as non-starter' do
    before(:each) do
    end

    context 'not full bidding yet' do
      before(:each) do
      @tender = FactoryGirl.create(:fresh_house_purchase_musharaka)
      assign(:tender, @tender)
      assign(:asset, @tender.tenderable)
      assign(:bids, @tender.bids)      
      view.stub(:current_user).and_return(@user)
      assign(:client, @tender.starter)        
        render
      end

      it "displays no control options" do
        expect(rendered).to have_content 'Kirim'
        expect(rendered).to_not have_link 'Kelola Proposal', href: edit_tender_path(@tender)
      end
    end

    context 'proposal target achieved' do
      before(:each) do
        @tender = FactoryGirl.create(:house_purchase_musharaka)
        assign(:tender, @tender)
        assign(:asset, @tender.tenderable)
        assign(:bids, @tender.bids.all)              
        view.stub(:current_user).and_return(@user)
        assign(:client, @tender.starter)        
        render
      end

      it "displays no control options" do
        expect(rendered).to have_content 'Kirim'
        expect(rendered).to_not have_link 'Kelola Proposal', href: edit_tender_path(@tender)
      end

      it 'shows all the bids' do
        expect(rendered).to have_selector('.bid-item', count: 2)
      end
    end
  end
end