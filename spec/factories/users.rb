FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
    sequence(:name) { |n| "Person #{n}" }
    
    factory :consumer do
      profile { { business: false, investor: false } }
    end

		factory :entrepreneur do
      profile { { business: true, investor: false } }
    end

    factory :admin do
			admin true
      profile { { business: true, investor: true } }
		end

    factory :investor do
      profile { { business: false, investor: true } }
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