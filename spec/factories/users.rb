FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "Person_#{n}@example.com" }
    sequence(:phone_number) { |n| "00700800#{n}" }
    password "foobarbaz"
    password_confirmation "foobarbaz"
    sequence(:full_name) { |n| "Person #{n}" }

		factory :admin do
			admin true
		end
  end

  # factory :roster do
  #   user
  #   active true

  #   factory :active_owner do
  #     role "Pemilik"
  #     rosterable_type "Firm"
  #   end

  #   factory :active_member do
  #     role "Anggota"
  #     rosterable_type "Firm"
  #   end

  #   factory :head_capitalist do
  #     role "Pemilik"
  #     rosterable_type "Backer"
  #   end    
  # end
  # trait :rosterable_id do
  #   rosterable_id
  # end


end