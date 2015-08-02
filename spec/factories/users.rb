FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
    sequence(:name) { |n| "Person #{n}" }
    
    factory :consumer do
      business false
      investor false
    end

		factory :entrepreneur do
      business true
      investor false

      factory :entrepreneur_with_team do
        after(:create) do |user|
          FactoryGirl.create(:business, starter_email: user.email)
        end
      end
    end

    factory :admin do
			admin true
      business true
      investor true
		end

    factory :investor do
      business false
      investor true
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

    trait :with_full_profile do
      phone_number "081398979879" 
      about "Lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor" 
      last_education "D3/Sarjana"
      marital_status "Menikah"
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