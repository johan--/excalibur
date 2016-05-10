require 'rails_helper'

feature "UserUploadsDocuments", :type => :feature do
  let!(:client) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: client) }  
  subject { page }

  before { sign_in client }

  describe "uploading file", js: true do
  	before do 
  	  click_link "Kelola"
  	  click_link('Pilih File') 
      click_link("", href: '#identity')
  	  # fill_in "document_name", with: "KTP Galih"
  	  attach_file('file', file_upload_fixture)
  	  select "KTP", from: "document_doc_type"
  	  click_button "Simpan"
  	end

	  it { should have_content("Dokumen berhasil disimpan") }

    describe "looking into the profile page" do
      before do
        click_link "Lihat"
        click_link("", href: '#portlet_tab2')
      end
      
      it { should have_content("KTP #{client.name}") }
    end
  end

end