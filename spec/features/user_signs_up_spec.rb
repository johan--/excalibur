require 'rails_helper'

feature "UserSignsUp", :type => :feature do
	subject { page }
	
	describe "Signing_Up" do
		before { visit new_user_registration_path }

		describe "with invalid information" do
			before { click_button "Daftar" }

			it { should have_content('Buat akun baru') }
		end

		describe "as beta-listed client with valid information" do
			let!(:subscriber) { FactoryGirl.create(:beta_user, :whitelisted) }
			before do
				fill_in("user[email]", with: subscriber.email)
				fill_in("user[password]", with: "foobarbaz")
				fill_in("user[password_confirmation]", with: "foobarbaz")
				fill_in("user[name]", with: "foobar baz")
				check "Saya setuju"
				select "Klien - Membutuhkan pembiayaan"
				click_button "Daftar"
			end

			it { should have_title('Beranda | siKapiten') }
			it { should have_content('Welcome! You have signed up successfully') }
			it { should have_css('.profile-usertitle-name', text: 'Foobar Baz') }
			it { should have_css('.profile-usertitle-job', text: 'Klien') }
			it { should_not have_link('Masuk', href: new_user_session_path) }
		end

		# describe "as beta-listed financier with valid information" do
		# 	let!(:subscriber) { FactoryGirl.create(:beta_financier, :whitelisted) }
		# 	before do
		# 		fill_in("user[email]", with: subscriber.email)
		# 		fill_in("user[password]", with: "foobarbaz")
		# 		fill_in("user[password_confirmation]", with: "foobarbaz")
		# 		fill_in("user[name]", with: "foobar baz")
		# 		check "Saya setuju"
		# 		select "Pendana - Ingin berinvestasi"
		# 		click_button "Daftar"
		# 	end

		# 	it { should_not have_title('Beranda | siKapiten') }
		# 	it { should have_content('Welcome! You have signed up successfully') }
		# 	it { should have_css('.profile-usertitle-job', text: 'Pendana') }
		# 	it { should_not have_link('Masuk', href: new_user_session_path) }

		# end
	end

end
