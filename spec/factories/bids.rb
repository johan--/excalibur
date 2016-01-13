FactoryGirl.define do

  factory :bid do
    association :tender, factory: :tender
    association :bidder, factory: :user
    volume 1000
    message "lorem ipsum dolor casus molar"


    trait :bidder do
      bidder
    end

    trait :confirmed do
      state "confirmed"
    end

    trait :nameless do
      before(:create) do |bid|
        bid.bidder = FactoryGirl.create :user
      end      
    end

    trait :half do
      volume 500
    end

    trait :quarter do
      volume 250
    end
  end
end