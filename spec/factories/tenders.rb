FactoryGirl.define do

  factory :tender do
    # association :tenderable, factory: :stock
    association :starter, factory: :user
    annum 8
    seed_capital 20
    draft "no"

    factory :fresh_house_purchase_musharaka do
      house_purchase
      musharaka
      full
      as_member
    end

    factory :house_purchase_musharaka do
      house_purchase
      musharaka
      full
      as_member

      after(:create) do |tender|
        FactoryGirl.create(:bid, tender: tender, volume: 800)
      end      
    end

    factory :musharaka_share_sale do
      share_purchase
      musharaka
      with_stock
      full
    end

    trait :house_purchase do
      category "fundraising"
      with_house
    end

    trait :share_purchase do
      category "trading"
    end

    trait :with_starter do 
      association :starter, factory: :user
    end 

    trait :with_stock do 
      after(:build) do |tender|
        stock = FactoryGirl.create(:stock)
        tender.tenderable = stock
      end
    end 

    trait :with_house do
      after(:build) do |tender|
        asset = FactoryGirl.create(:complete_house)
        tender.tenderable = asset
        tender.price = 300000
      end      
    end

    trait :as_member do
      participate 'yes'
    end

    trait :not_as_member do
      participate 'no'
    end

    trait :draft do
      draft "yes"
    end

    trait :musharaka do
      aqad "musharaka"
      unit "ownership"
    end

    trait :half do
      volume 500
    end

    trait :quarter do
      volume 250
    end

    trait :starter do
      starter
    end

    trait :full do
      price 300000 # one hundred thousand
      volume 1000
    end
  end 

end