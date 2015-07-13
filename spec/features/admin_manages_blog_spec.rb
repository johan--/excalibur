require 'rails_helper'

feature "AdminManagesBlog", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:player) }
  let!(:post1) { FactoryGirl.create(:post, user: admin) }

  describe "viewing blog index" do
  	before do
  	  sign_in user
  	  switch_to_subdomain('blog')
  	  visit root_path
  	end

  	it { should have_content('Blog siKapiten') }
  	it { should have_content(post1.title) }
  end

  describe "a single blog post" do
  end

  describe "create a post" do
  	before(:each) do
  	  sign_in admin
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
