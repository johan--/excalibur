FactoryGirl.define do

  factory :tender do
    # association :tenderable, factory: :stock
    association :starter, factory: :user
    annum 8
    draft "no"
    message "Lorem ipsum dolor cassus"

    factory :house_purchase_murabaha_tender do
      house_purchase
      murabaha
      with_stock
      negotiate
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

    trait :with_starter do 
      association :starter, factory: :user
    end 

    trait :with_stock do 
      after(:build) do |tender|
        stock = FactoryGirl.create(:stock)
        tender.tenderable = stock
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

    trait :negotiate do
      price 300000 # one hundred thousand
      volume 1000
    end
  end 

end