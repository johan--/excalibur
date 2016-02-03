require 'rails_helper'

feature "AdminAssessClients", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:client) { FactoryGirl.create(:user) }
  let!(:tender) { FactoryGirl.create(:house_purchase_murabaha_tender,
                    starter: client) }

  before do 
  	sign_in admin 
  	visit tender_path(tender)
  end  

  describe "filling out the comment form of the client", js: true do
  	before do
      click_link "Bursa"
      first('.tender-item').click
      click_link "Diskusi"
  	  # click_link("Forum", href: "#portlet_tab2")
  	  click_link "Buat Analisis"
      fill_in "comment_title", with: "Assessment Personality"
  	  fill_in "comment_body_md", with: "Lorem ipsum dolor Lorem 
  	  				ipsum dolor Lorem ipsum dolor Lorem ipsum dolor"
  	  click_button "Simpan"
  	end

  	it { should have_content('Assessment berhasil dibuat') }

    describe "going into the tender page" do
      before do 
        visit tender_path(tender)
        click_link("Forum", href: "#portlet_tab2")
      end

      it "should display the assessment" do
        expect(page).to have_css('.comment-content', 
          text: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor")
      end
      it "shows that the starter of the tender also made a bid" do
        expect(find('#forum')).to have_selector('div.comment-item', count: 1)
      end
    end

  end

end