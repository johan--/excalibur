require 'rails_helper'

feature "UserOpensATender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:player) }  

  before { sign_in user }

  describe "creating a tender for vehicle" do
  	before do  
  	  click_link "Buat Pengajuan", href: new_tender_path(cat: "kendaraan")
  	  fill_in "Besaran (Rp)", with: "15000000"
  	  click_button "Ajukan"
  	end

  	it { should have_content('Pengajuan pembiayaan berhasil dilakukan') }
  end

end
