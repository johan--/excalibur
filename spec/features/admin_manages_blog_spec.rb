require 'rails_helper'

feature "AdminManagesBlog", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:entrepreneur) }
  let!(:post1) { FactoryGirl.create(:post_with_user, :dummy_keywords) }
  let!(:comment1) { FactoryGirl.create(:post_comment, :with_user, commentable: post1) }

  describe "as admin" do
    before(:each) do
      sign_in admin
      switch_to_subdomain('blog')
      visit root_path      
    end

    describe "viewing a single blog post" do
      before do 
        click_link post1.title, match: :first
      end

      it { should have_link('Edit') }
    end

    describe "moderating a comment", js: true do
      before do
        find("a", text: post1.title).trigger("click")
        click_link 'Edit'
        within(:div, '.modal-body') do
          fill_in 'comment_body', with: "Blablabla lorem"
          click_button "Simpan", match: :prefer_exact
        end
      end

      it { should have_content('Komentar berhasil dikoreksi') }
      it { should have_content('Blablabla lorem') }
    end

    describe "create a post" do
      before(:each) do
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
  end

  # describe "as visitor" do
  #   before(:each) do
  #     switch_to_subdomain('blog')
  #     visit root_path      
  #   end

  #   describe "viewing blog index" do
  #   	it { should have_content('Blog siKapiten') }
  #   	it { should have_content(post1.title) }
  #   end

  #   describe "a single blog post" do
  #     before { click_link post1.title, match: :first }

  #     it { should have_css('.ctitle', text: post1.title) }
  #     it { should have_css('.post-content', text: post1.content_md) }
  #     it { should have_css('.well', text: "Daftar Komentar") }
  #     it { should have_css('.comment-item', text: comment1.body) }
  #     it { should have_css('#new-comment') }
  #     it { should have_no_link('Moderasi') }
  #   end
  # end

end