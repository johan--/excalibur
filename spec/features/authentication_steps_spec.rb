require 'rails_helper'

feature "AuthenticationSteps", :type => :feature do
	let!(:user_1) { FactoryGirl.create(:user) }
	let!(:admin) { FactoryGirl.create(:admin) }
	let!(:post1) { FactoryGirl.create(:post, user: user_1) }
	subject { page }

	describe "authorization" do
		describe "for non-signed-in user" do

			describe "in the Pages Controller" do
				# describe "visiting the landing page" do
				# 	before { visit root_path }
				# 	it { should have_title('Welcome') }
				# end

				describe "visiting the home page" do
					before { visit home_path }
					it { should have_title('Masuk') }
				end				

				describe "visiting the blog page" do
					before { visit posts_path }
					it { should have_title('Blog') }
				end

			end

			describe "in the Posts Controller (Admin)" do
				describe "visiting dasboard" do
					before { visit admin_posts_dashboard_path }
					it { should have_title('Masuk') }
				end

				describe "visiting index" do
					before { visit admin_posts_path }
					it { should have_title('Masuk') }
				end

				describe "visiting new page" do
					before { visit new_admin_post_path }
					it { should have_title('Masuk') }
				end				

				describe "visiting edit page" do
					before { visit edit_admin_post_path(post1.slug) }
					it { should have_title('Masuk') }
				end				

				describe "visiting drafts page" do
					before { visit admin_posts_drafts_path }
					it { should have_title('Masuk') }
				end				
			end

			describe "in the Users Controllers (Admin)" do
				describe "visiting index" do
					before { visit admin_users_path }
					it { should have_title('Masuk') }
				end

				describe "visiting show page" do
					before { visit admin_user_path(user_1) }

					it { should have_title('Masuk') }
				end				
			end
		end

		describe "for non-admin user" do
			before { sign_in user_1 }

			describe "in the Pages Controller" do
				describe "visiting the home page" do
					before { visit home_path }
					it { should have_title('Home') }
				end				

				describe "visiting the blog page" do
					before { visit posts_path }
					it { should have_title('Blog') }
				end

				describe "visiting the contact page" do
					before { visit contact_path }
					it { should have_title('Kontak') }
				end
			end

			describe "in the Posts Controller" do
				describe "visiting dasboard" do
					before { visit admin_posts_dashboard_path }
					it { should have_title('Home') }
				end

				describe "visiting index" do
					before { visit admin_posts_path }
					it { should have_title('Home') }
				end

				describe "visiting new page" do
					before { visit new_admin_post_path }
					it { should have_title('Home') }
				end				

				describe "visiting edit page" do
					before { visit edit_admin_post_path(post1.slug) }
					it { should have_title('Home') }
				end				

				describe "visiting drafts page" do
					before { visit admin_posts_drafts_path }
					it { should have_title('Home') }
				end
			end

			describe "in the Users Controllers (Admin)" do
				describe "visiting index" do
					before { visit admin_users_path }
					it { should have_title('Home') }
				end

				describe "visiting show page" do
					before { visit admin_user_path(user_1) }
					it { should have_title('Home') }
				end				
			end		
		end

	end
end