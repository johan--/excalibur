require 'rails_helper'

feature "CompanyHandlesProfile", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:entrepreneur) }
  let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }

  before { sign_in user }

  describe "when the biz has no profile yet" do
    it { should have_link("Lihat Profil Bisnis") }

  	context "fill biz profile", js: true do
      before do
        click_link "Edit Profil Bisnis"
        fill_in "business_about", with: "Lorem Ipsum Dolor Casuss"
        fill_in "business_anno", with: "2015"
        fill_in "business_founding_size", with: "4"
        check "Kantor Utama"
        check "Gerai"
        check "Jaringan Sosial"
        check "Messaging/Chatting App"
        click_button "Simpan"
      end

      it { should have_content("Profil bisnis berhasil diperbaharui") }

      context "looking into the profile" do
        before { click_link "Lihat Profil Bisnis" }

        it { should have_css('.bio', text: "Lorem Ipsum Dolor Casuss") }
        it { should have_css('#established', text: "2015") }
        it { should have_css('#founders', text: "4") }
      end

      context "editing the profile" do
        before do
          visit user_root_path 
          click_link "Edit Profil Bisnis" 
          fill_in "business_about", with: "Blabla galih blabla"
          # fill_in "business_anno", with: "2015"
          # fill_in "business_founding_size", with: "4"
          click_button "Simpan"
        end

        it { should have_content("Profil bisnis berhasil diperbaharui") }

        it "shows changes on the show profile page" do
          click_link "Lihat Profil Bisnis"

          expect(page).to have_css('.bio', text: "Blabla galih blabla") 
        end
      end

    end
  end

end