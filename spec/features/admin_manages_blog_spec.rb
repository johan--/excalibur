require 'rails_helper'

feature "AdminManagesBlog", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post1) { FactoryGirl.create(:post_with_user, :dummy_keywords) }

  before(:each) do
    sign_in admin
  end

  describe "create a post" do
    before do
      visit new_admin_post_path
    end

    context "publish immediately" do
      before(:each) do
        fill_in "post_title", with: "Admin Post 1"
        fill_in "post_content_md", with: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor"
        fill_in "post_topic", with: "test dummy"
        click_button "Simpan"
      end

      it { should have_content("New post published.") }
    end

  end

  describe "editing a single blog post" do
    before do 
      # visit admin_posts_path
      # click_link("Edit", match: :first)
      visit edit_admin_post_path(post1)
      fill_in "post_content_md", with: "Cech monreal almunia bellerin per mertesacker arteta"
      click_button "Simpan"
    end

    it { should have_content("Post successfully edited.") }
    it { should_not have_content("Lorem ipsum dolor Lorem ipsum dolor") }
  end


end