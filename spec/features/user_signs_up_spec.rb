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
			let!(:subscriber) { FactoryGirl.create(:beta_user) }

			before do
				fill_in("user[email]", with: subscriber.email)
				fill_in("user[password]", with: "foobarbaz")
				fill_in("user[password_confirmation]", with: "foobarbaz")
				fill_in("user[name]", with: "foobar baz")
				check "Saya setuju"
				click_button "Daftar"
			end

			it { should have_title('Beranda | siKapiten') }
			it { should have_content('Welcome! You have signed up successfully') }
			it { should have_link('Keluar') }
			it { should_not have_link('Masuk', href: new_user_session_path) }
		end

		# describe "as manager with valid information" do
		# 	# before do
		# 	# 	fill_in("user[email]", with: "manager@example.com")
		# 	# 	fill_in("user[password]", with: "foobarbaz")
		# 	# 	fill_in("user[password_confirmation]", with: "foobarbaz")
		# 	# 	fill_in("user[name]", with: "Manager1")
		# 	# 	# fill_in("user[phone_number]", with: "11111111")
		# 	# 	choose 'Pengelola'
		# 	# 	click_button  "Daftar"
		# 	# end

		# 	# it { should have_title('Daftarkan Bisnismu') }

		# 	# describe "create a new firm" do
		# 	# 	before do
		# 	# 		fill_in("firm[name]", with: "PT. Futsal Indonesia")
		# 	# 		fill_in("firm[city]", with: "DKI Jakarta")
		# 	# 		fill_in("firm[address]", with: "Jl. Blabla No. 99")
		# 	# 		fill_in("firm[phone]", with: "123456789")
		# 	# 		click_button  "Proses"
		# 	# 	end

		# 	# 	it { should have_content('PT. Futsal Indonesia') }
		# 	# 	it { should have_content('Bisnismu berhasil didaftarkan') }

		# 	# 	describe "subscription-state" do
		# 	# 		before { click_link "Langganan", match: :first }
				
		# 	# 		it { should have_css('#subscription-state', text: 'Aktif') }
		# 	# 	end

		# 	# 	# it { should have_css('#no-venue', text: 'Daftarkan Arena') }
		# 	# end

		# 	# describe "find an existing firm" do
		# 	# 	let!(:firm_1) { FactoryGirl.create(:firm_with_team, :with_subscription) }

		# 	# 	before do
		# 	# 		click_link "Klik di sini"
		# 	# 		fill_in "q[name_cont]", with: firm_1.name
		# 	# 		fill_in "q[address_cont]", with: firm_1.address
		# 	# 		click_button  "Cari"
		# 	# 	end

		# 	# 	it { should have_content('1 hasil ditemukan') }
		# 	# 	it { should have_content(firm_1.name) }

		# 	# 	describe "joining one of it" do
		# 	# 		before { click_link '', href: join_firm_path(firm_1) }

		# 	# 		it { should have_content('Tunggu konfirmasi dari moderator bisnis ini') }
		# 	# 		it { should have_no_content(firm_1.name) }
					
		# 	# 		describe "entering the biz dashboard " do
		# 	# 			before { visit biz_root_path }

		# 	# 			# Should be redirected because status is still
		# 	# 			# pending
		# 	# 			it { should have_title('Blog') }
		# 	# 		end					
		# 	# 	end
		# 	# end			
		# end		
	end

end
