FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    # sequence(:phone_number) { |n| "00700800#{n}" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
    sequence(:full_name) { |n| "Person #{n}" }
    
		factory :player do
      category 1
    end

    factory :admin do
			admin true
      category 3
		end

    factory :manager do
      category 2
    end

    factory :facebook_user do
      after(:create) do |user|
        create(:identity, :facebook, user: user)
      end
    end

    factory :google_user do
      after(:create) do |user|
        create(:identity, :google, user: user)
      end
    end    
  end

  factory :identity do
    user

    trait :facebook do
      provider 'facebook'
      uid 'facebook-user-id'
    end

    trait :google do
      provider 'google'
      uid 'google-user-id'
    end
  end


end