require 'rails_helper'

feature "BusinessOpensATender", :type => :feature do
  # subject { page }
  # let!(:user) { FactoryGirl.create(:entrepreneur) }
  # let!(:biz) { FactoryGirl.create(:business, starter_email: user.email) }

  # before { sign_in user }

  # describe "when there is no tender yet" do
  #   context "on the home page" do  	  
  #   end

  #   context "creating a tender", js: true do
  #     before do
  #       visit user_root_path
  #       click_link("Buat Pengajuan", href: new_business_tender_path(biz))
  #       fill_in "tender_target", with: 123456
  #       fill_in "tender_summary", with: "Lorem Ipsum Dolor Casuss"
  #       fill_in "tender_aqad", with: "Musharakah"
  #       fill_in "tender_intent_type", with: "Ekspansi"
  #       check "Mesin"
  #       click_button "Ajukan"
  #     end
      
  #     it { should have_content('Proposal berhasil dibuat') }

  #     context "should have tender listed on tender tab" do
  #       before { click_link("", href: '#portlet_tab2') }

  #       it { should have_content("Rp 123.456") }
  #     end
  #   end
  # end

  # describe "when there is a tender" do
  #   let!(:tender) { FactoryGirl.create(:retail, :musharakah, tenderable: biz) }

  #   describe "editing the tender", js: true do
  #     before do
  #       visit user_root_path
  #       click_link("", href: '#portlet_tab2')
  #       click_link("Edit", href: edit_business_tender_path(biz, tender))
  #       # fill_in "tender_target", with: 654321
  #       fill_in "tender_aqad", with: "Murabahah"
  #       click_button "Ajukan"
  #     end

  #     it { should have_content('Proposal berhasil dikoreksi') }
  #     # it { should have_css('.price', text: "Rp 654.321") }
  #   end
  # end

  # describe "when there are a lot of tenders" do
  #   let!(:tender_2) { FactoryGirl.create(:retail, :musharakah, :with_biz) }
  #   let!(:tender_3) { FactoryGirl.create(:retail, :musharakah, :with_biz) }

  #   before do
  #     visit user_root_path
  #     click_link("", href: '#portlet_tab2')
  #   end

  #   it { should have_no_link("Edit", href: edit_business_tender_path(tender_2.tenderable, tender_2)) }
  #   it { should have_no_link("Edit", href: edit_business_tender_path(tender_3.tenderable, tender_3)) }
  # end

end