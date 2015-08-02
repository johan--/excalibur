require 'rails_helper'

feature "BusinessOpensATender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:entrepreneur) }
  let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }

  before { sign_in user }

  describe "when there is no tender yet" do
    context "on the home page" do  	  
    end

    context "creating a tender", js: true do
      before do
        visit user_root_path
        click_link("Buat", href: new_business_tender_path(biz))
        fill_in "tender_target", with: 123456
        fill_in "tender_summary", with: "Lorem Ipsum Dolor Casuss"
        fill_in "tender_aqad", with: "Musharakah"
        fill_in "tender_intent_type", with: "Ekspansi"
        check "Mesin"
        click_button "Ajukan"
      end
      
      it { should have_content('Proposal berhasil dibuat') }
      it { should have_content("Rp 123.456") }
    end
  end

  describe "when there is a tender yet" do
    let!(:tender) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }

    describe "editing the tender", js: true do
      before do
        visit user_root_path
        click_link("Koreksi", href: edit_business_tender_path(biz, tender))
        # fill_in "tender_target", with: 654321
        fill_in "tender_aqad", with: "Murabahah"
        click_button "Ajukan"
      end

      it { should have_content('Proposal berhasil dikoreksi') }
      # it { should have_css('.price', text: "Rp 654.321") }
    end
  end

end