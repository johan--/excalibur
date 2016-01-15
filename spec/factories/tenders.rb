FactoryGirl.define do

  factory :tender do
    association :house, factory: :house
    association :tenderable, factory: :user
    price 100000 # one hundred thousand
    volume 1000
    annum 8
    draft "no"
    message "Lorem ipsum dolor cassus"

    factory :house_purchase_murabaha_tender do
      house_purchase
      murabaha
    end

    trait :house_purchase do
      category "house purchase"
      unit "revenue shares"
    end

    trait :share_purchase do
      category "share purchase"
      unit "ownership shares"
    end

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
      draft "yes"
    end

    trait :musharaka do
      aqad "musharaka"
    end

    trait :murabaha do
      aqad "murabaha"
    end

    trait :mudharaba do
      aqad "mudharaba"
    end

    trait :half do
      volume 500
    end

    trait :quarter do
      volume 250
    end

    trait :tenderable do
      tenderable
    end
  end 

end