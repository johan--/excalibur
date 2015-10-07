require 'rails_helper'

feature "GuestUserVisitsBlog", :type => :feature do
  # subject { page }
  # let!(:post1) { FactoryGirl.create(:post_with_user, :dummy_keywords) }
  # let!(:comment_body) { "In the land of gods and monsters, I was an angel" }

  # before(:each) do
  #   switch_to_subdomain('blog')
  #   visit root_path
  # end

  # describe "clicking a tag" do
  #   before { click_link "test" } # one of the post1's tag

  #   it { should have_content('Hasil Pencarian Artikel') }
  #   it { should have_content(post1.title) }
  # end

  # describe "visit a single post page" do
  # 	before(:each) do
  #     # find("a", text: post1.title).trigger("click")
  #     first(:link, post1.title).click
  # 	end

  #   it { should have_no_link('Edit') }

  # 	context "posting a comment" do
  # 	  before do
  # 	  	fill_in 'comment_body', with: comment_body
  # 	  	click_button "Simpan"
  # 	  end

  # 	  it { should have_content('Komentar berhasil dibuat') }
  # 	  it { should have_css('.ctitle', text: post1.title) }
  # 	  it { should have_css('.comment-item', text: comment_body) }
  #     it { should have_link('Edit') }

  #     # context "Editing his fresh comment" do
  #     #   before do
  #     #     click_link 'Edit'
  #     #     within(:div, '.modal-body') do
  #     #       fill_in 'comment_body', with: 'Oops Sorry, wrong blog'
  #     #       click_button "Simpan", match: :prefer_exact
  #     #     end          
  #     #   end

  #     #   it { should have_content('Komentar berhasil dikoreksi') }
  #     #   it { should have_content("Oops Sorry, wrong blog") }
  #     # end

  # 	end
  # end

  # describe "when there is a comment" do
  #   let!(:parent_comment) { FactoryGirl.create(:post_comment, :with_user, commentable: post1) }
  #   # before { click_link post1.title, match: :first }

  #   context "replying to a comment", js: true do  
  #     before do
  #       find("a", text: post1.title).trigger("click")
  #       click_link 'Balas'
  #       within(:div, '.modal-body') do
  #         fill_in 'comment_body', with: comment_body
  #         click_button "Simpan", match: :prefer_exact
  #         # find("input.btn", text: "").trigger("click")
  #       end
  #     end

  #     it { should have_content('Komentar berhasil dibuat') }
  #     it { should have_css('.ctitle', text: post1.title) }
  #     it { should have_content(comment_body) }
  #   end    
  # end

end
