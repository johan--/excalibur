require 'rails_helper'

feature "BusinessOpensATender", :type => :feature do
  subject { page }
  let!(:user) { FactoryGirl.create(:player) }
  let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }

  before { sign_in user }

  describe "when there is no tender yet" do
    context "on the home page" do  	  
    end

    context "creating a tender" do
      before do
        click_link "Buat Pengajuan Pembiayaan"
        fill_in "biz_partnership_target", with: 123456
        fill_in "biz_partnership_properties_aqad", with: "Musharakah"
        fill_in "biz_partnership_properties_summary", with: "Lorem Ipsum Dolor Casuss"
        fill_in "biz_partnership_details_intent_type", with: "Ekspansi"
        check "Mesin"
        click_button "Ajukan"
      end
      
      it { should have_content('Pengajuan pembiayaan berhasil dilakukan') }
      it { should have_css('.target', text: 'Pengajuan pembiayaan berhasil dilakukan') }
    end
  end

  # describe "when there is a tender yet" do
  #   it { should have_content('Pengajuan pembiayaan berhasil dilakukan') }
  # end

end
