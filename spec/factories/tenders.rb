FactoryGirl.define do

  factory :tender do
    summary "Lorem ipsum dolor cassus"

    target 300000000
    category "Penggalangan"
    intent "pembelian rumah"
    # tangible "rumah tunggal"
    own_capital 30
    maturity 8
    broadcast "true"
    draft "false"
    state "open"
    association :house, factory: :house
    association :tenderable, factory: :user

    trait :success do
      state "success"

      transient do
        count 4
      end

      after(:build) do |tender|
        FactoryGirl.create(:bid, :nameless, :confirmed, :tender => tender, shares: 1000)
      end
    end      

    trait :with_tenderable do 
      association :tenderable, factory: :user
    end 

    trait :with_house do 
      after(:build) do |tender|
        tender.house = FactoryGirl.create(:house, :with_developer)
      end
    end 

    trait :draft do
      draft "true"
    end

    trait :musharakah do
      aqad "musyarakah"
    end

    trait :murabahah do
      aqad "murabahah"
    end

    trait :tenderable do
      tenderable
    end
  end 

end