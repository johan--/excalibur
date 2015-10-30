FactoryGirl.define do

  factory :subscriber do
    email "foobarbaz@gmail.com"

    factory :beta_user do
      category "registration"
    end

    factory :beta_financier do
      category "investor"
    end

    factory :blog_subscriber do
      category "blog"
    end    

    trait :whitelisted do
      name "whitelisted"
    end
  end

end