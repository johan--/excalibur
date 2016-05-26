require 'rails_helper'

feature "AdminAssessClients", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:client) { FactoryGirl.create(:user) }

  before do 
  	sign_in admin 
  	click_link "Users"
  	within("tr#no-#{client.id}") do
  	  click_link "Kelola"
  	end
  end  

  describe "filling out the comment form of the client" do
  	before do
      fill_in "comment_title", with: "Assessment For The Client"
  	  fill_in "comment_body_md", with: "Lorem ipsum dolor Lorem 
  	  				ipsum dolor Lorem ipsum dolor Lorem ipsum dolor"
  	  click_button "Simpan"
  	end

  	it { should have_content('Assessment berhasil dibuat') }

  	it "should display the assessment" do
  	  expect(page).to have_css('.message', 
  	      text: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor")
  	end
  	
  	it "shows that the starter of the tender also made a bid" do
  	  expect(page).to have_selector('.testimonial-item', count: 1)
  	end

    context "on the client profile page" do
      before { visit user_path(client) }

      it "should display the assessment" do
        expect(page).to have_css('.message', 
            text: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor")
      end

      it "shows that the starter of the tender also made a bid" do
        expect(page).to have_selector('.testimonial-item', count: 1)
      end
    end
  end

end