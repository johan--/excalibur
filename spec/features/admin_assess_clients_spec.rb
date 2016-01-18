require 'rails_helper'

feature "AdminAssessClients", :type => :feature do
  subject { page }

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:tender) { FactoryGirl.create(:tender, :murabaha, :house_purchase) }

  before do 
  	sign_in admin 
  	visit tender_path(tender)
  end  

  describe "filling out the comment form of the client", js: true do
  	before do
  	  # click_link("", href: "#portlet_tab2")
  	  click_link "Buat Analisis"
  	  fill_in "comment_body", with: "Lorem ipsum dolor Lorem 
  	  				ipsum dolor Lorem ipsum dolor Lorem ipsum dolor"
  	  click_button "Share"
  	  click_link("", href: "#portlet_tab2")
  	end

  	it { should have_content('Komentar berhasil dibuat') }
  	it { should have_content("Lorem ipsum dolor Lorem 
  	  				ipsum dolor Lorem ipsum dolor Lorem ipsum dolor") }
  	
  	# describe "when viewing the comment tabs" do
  	#   before do 
  	#   end

  	# end
  end

end