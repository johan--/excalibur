require 'rails_helper'

feature "UserUploadsDocuments", :type => :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:proposal) { FactoryGirl.create(:fresh_house_purchase_musharaka, 
                                        starter: user) }

  subject { page }

  before(:each) { sign_in user }


  describe "uploading file" do
  	before do 
  	  click_link "Lihat profil"
  	  click_link 'Unggah berkas'
      # click_link("", href: '#identity')
  	  attach_file('file', file_upload_fixture)
  	  # within(:div, '#identity') do
        select "KTP", from: "document_doc_type"
      # end
  	  click_button "Simpan"
  	end

	  it { should have_content("Dokumen berhasil disimpan") }
    it { is_expected.to have_selector('li.bid-item', count: 1) }
    it { is_expected.to have_selector('.category', text: 'identitas') }
    it { is_expected.to have_selector('.doc_type', text: 'KTP') }
    # it { should have_content("blablabla") }
    
    # describe "then deleting it", js: true do
    #   before do
    #     click_link "Kelola Berkas"
    #     find('.delete-link').click
    #   end
      
    #   it { should have_content("Dokumen berhasil dihapus") }
    # end
  end

end