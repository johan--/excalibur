require 'rails_helper'

describe 'users/show.html.erb', :type => :view do
  before(:each) { @user =  FactoryGirl.create(:user) }

  context 'the current_user viewing his/her profile' do
    before(:each) do
      view.stub(:current_user).and_return(@user)
      assign(:user, @user)
      assign(:tenders, @user.tenders)
      assign(:documents, @user.documents)

      render
    end
    subject { rendered }

    it { is_expected.to have_selector('#like-button') }
    
  end

  context 'the current_user viewing other user profile' do
  end  
end