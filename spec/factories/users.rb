FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    sequence(:phone_number) { |n| "00700800#{n}" }
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
  end

end