require 'rails_helper'

feature "VisitorOpensPages", type: :feature do
  subject { page }


  context "unrestricted pages, open to public" do
    describe "visit password edit page" do
      before do 
        visit new_user_password_path
      end

      it { is_expected.to have_title "Reset Password Page | SiKapiten" }
    end

    describe "visit a house show page" do
    	let!(:house) { FactoryGirl.create(:complete_house) }

    	before { visit house_path(house) }

    	it { is_expected.to have_content house.address }
    end

    describe "visit a tender show page" do
      let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka) }

      before { visit tender_path(proposal) }

    	it { is_expected.to have_content proposal.ticker }
    end


    describe "visit blog page" do
    	let!(:post1) { FactoryGirl.create(:post_with_user, :dummy_keywords) }

    	before { visit blog_path }

    	it { is_expected.to have_content post1.title }
    end

    describe "visit wiki page" do
      before { visit wiki_all_path }

      it { is_expected.to have_content "Artikel Wiki" }
    end
  end

  context "restricted, only for authenticated users" do
    describe "visit home page" do
      before { visit user_root_path }

      it { is_expected.to have_title "Log In Page" }
    end    

    describe "visit user profile" do
      let!(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { is_expected.to have_title "Log In Page" }
    end
  end
end