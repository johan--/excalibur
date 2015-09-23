require 'rails_helper'

feature "ClientUploadsDocuments", :type => :feature do
  subject { page }
  let!(:consumer) { FactoryGirl.create(:client) }

  before { sign_in consumer }

  describe "in the home page" do
  	it { should have_link('Unggah Berkas', href: new_document_path) }
  end

  describe "uploading file", js: true do
  	before do 
  		click_link('Unggah Berkas') 
  		fill_in "document_name", with: "KTP Galih"
  		attach_file('file', file_upload_fixture)
  		select "Identifikasi", from: "document_category"
  		click_button "Simpan"
  	end

	it { should have_content("Dokumen berhasil disimpan") }
  end

end
