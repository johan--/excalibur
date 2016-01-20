FactoryGirl.define do

  factory :tender do
    # association :tenderable, factory: :stock
    association :starter, factory: :user
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
      with_stock
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

    trait :with_starter do 
      association :starter, factory: :user
    end 



    trait :with_stock do 
      after(:build) do |tender|
        house = FactoryGirl.create(:house, :with_developer)
        tender.tenderable = house.stocks.first
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

    trait :starter do
      starter
    end
  end 

end