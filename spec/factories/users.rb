FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
    sequence(:name) { |n| "Person #{n}" }
    sequence(:phone_number) { |n| "05392421#{n}" }
    understanding "true"
    developer "false"

    factory :developer do
      developer "true"
    end

    factory :admin do
			admin true
      developer "true"
		end

    factory :fb_user do
      auth_with 'facebook'
      after(:create) do |user|
        create(:fb_omni, user: user)
      end      
    end

    # factory :facebook_user do
    #   after(:create) do |user|
    #     create(:identity, :facebook, user: user)
    #   end
    # end
    # factory :google_user do
    #   after(:create) do |user|
    #     create(:identity, :google, user: user)
    #   end
    # end
    # factory :linkedin_user do
    #   after(:create) do |user|
    #     create(:identity, :linkedin, user: user)
    #   end
    # end

    trait :with_full_profile do
      phone_number "081398979879" 
      about "Lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor" 
      last_education "D3/Sarjana"
      marital_status "Menikah"
    end    
  end

  factory :identity do
    user
    token "afiafi0oqafoibqanfoiqa"

    factory :fb_omni do
      # before(:create) do |identity|
      #   identity.user = FactoryGirl.create :user
      # end
      facebook      
    end

    trait :facebook do
      last_name 'facebooker'
      provider 'facebook'
      uid 'facebook-user-id'
    end

    trait :google do
      last_name 'googler'
      provider 'google'
      uid 'google-user-id'
    end

    trait :linkedin do
      last_name 'link'
      provider 'linkedin'
      uid 'linkedin-user-id'
    end    
  end


end