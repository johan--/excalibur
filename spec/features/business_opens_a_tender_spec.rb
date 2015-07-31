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
        click_link "Buat Pengajuan"
        fill_in "tender_target", with: 123456
        fill_in "tender_summary", with: "Lorem Ipsum Dolor Casuss"
        fill_in "tender_aqad", with: "Musharakah"
        fill_in "tender_intent_type", with: "Ekspansi"
        check "Mesin"
        click_button "Ajukan"
      end
      
      it { should have_content('Pengajuan pembiayaan berhasil dibuat') }
      it { should have_css('.target', text: 123456) }
    end
  end

  # describe "when there is a tender yet" do
  #   it { should have_content('Pengajuan pembiayaan berhasil dilakukan') }
  # end

end
