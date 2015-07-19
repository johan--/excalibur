require 'rails_helper'

feature "FirmCreatesProfile", :type => :feature do
  subject { page }
  let!(:player) { FactoryGirl.create(:player) }
  # let!(:firm) { FactoryGirl.create(:firm_with_reports) }  
  # let!(:as_owner) { FactoryGirl.create(:active_owner, user: user, rosterable_id: firm.id) }  

  before { sign_in user }

  describe "create user profile" do
  	click_link "Buat Profil Pengguna"
  end

  # describe "profile form field for firm" do
  # 	before { click_link "Buat Profil Usaha" }

  # 	it { should have_field("Skala Bisnis") }
  # 	it { should have_field("Jenis Nomor Identifikasi") }
  # 	it { should have_field("Nomor Identifikasi") }
  # 	it { should have_field("Rincian Usaha") }

  # 	describe "filling the form" do
  # 		before do
	 #        select "Daerah", from: 'Skala Bisnis'
	 #        select "SIUP", from: "Jenis Nomor Identifikasi"
	 #        fill_in "Nomor Identifikasi", with: 1213141410
	 #        fill_in "Nama Alamat", with: "Kantor Pusat"
	 #        select "Sumatera", from: "Kawasan"
	 #        fill_in "Kota", with: "Medan"
	 #        fill_in "Alamat Lengkap", with: "Jl. blabla No. 99 RT 99 RW 98 bla bla"
	 #        click_button "Simpan" 
  #   	end

  #       it { should have_content("Profil Usaha berhasil dibuat") }
  # 	end
  # end
end