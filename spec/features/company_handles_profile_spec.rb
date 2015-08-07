require 'rails_helper'

feature "CompanyHandlesProfile", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:entrepreneur) }
  let!(:biz) { FactoryGirl.create(:business, :with_profile, starter_email: user.email) }

  before { sign_in user }

  describe "looking into profile" do
    before { click_link("Lihat", href: business_path(biz)) }

    it { should have_css('#bio', text: biz.about) }
    it { should have_css('#founding', text: biz.anno) }
    it { should have_css('#founding', text: biz.founding_size) }
  end

  describe "editing biz profile" do
  	context "fill biz profile", js: true do
      before do
      	visit user_root_path
        click_link("Edit", href: edit_business_path(biz))
        fill_in "business_about", with: "Lorem Ipsum Dolor Casuss"
        # fill_in "business_anno", with: "2015"
        # fill_in "business_founding_size", with: "4"
        check "Kantor Utama"
        check "Gerai"
        check "Jaringan Sosial"
        check "Messaging/Chatting App"
        click_button "Simpan"
      end

      it { should have_content("Profil bisnis berhasil diperbaharui") }
      it { should have_css('#bio', text: "Lorem Ipsum Dolor Casuss") }

    end
  end

end