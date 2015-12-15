FactoryGirl.define do

  factory :term_sheet do
    category
    state "trade"
    aqad "murabaha"
    deal

    trait :fresh do
    end

    trait :client do
      association :recipient, factory: :user, strategy: :build
    end

    trait :with_deal do 
      association :deal, factory: :consumer_deal
    end 
  end

end