require 'rails_helper'

feature "VisitorRunsSimulations", :type => :feature do
  subject { page }

  before(:each) { visit root_path }
  # let!(:murabaha) { MurabahaSimulation.new(maturity: params[:maturity], 
  #       price: 500000000, tangible: "Rumah", 
  #       contribution_percent: 30) }

  describe "running a murabaha simulation", js: true do
  	before do
  	  within('#tab1') do
  	    select "Rumah", from: "tangible"
        fill_in "price", with: 500000000
        fill_in "maturity", with: 8
        fill_in "contribution_percent", with: 30
        click_button "Hitung Cicilan Bulanan"
  	  end
    end

    it { should have_css('#price', text: "Rp 597.500.000") }
    it { should have_content('Hasil Simulasi') }
  end

  describe "running a musharaka simulation", js: true do
  	before do
  	  click_link "Musyarakah"
  	  within('#tab2') do
  	    select "Rumah", from: "tangible"
        fill_in "price", with: 500000000
        fill_in "maturity", with: 8
        fill_in "contribution_percent", with: 30
        click_button "Hitung Sewa Bulanan"
  	  end
    end

    it { should have_css('#first', text: "Rp 150.000.000") }
    it { should have_css('#contribution', text: "30%") }
  end

end
