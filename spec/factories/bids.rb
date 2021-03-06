FactoryGirl.define do

  factory :bid do
    association :tender, factory: :tender
    association :bidder, factory: :user
    volume 1000

    factory :bid_for_purchase_musharaka do
      for_purchase_musharaka
    end

    trait :for_purchase_musharaka do
      association :tender, factory: :fresh_house_purchase_musharaka
    end

    trait :bidder do
      bidder
    end

    trait :tender do
      tender
    end

    trait :success do
      after(:create) do |bid|
        # bid,
        bid.approving!
      end      
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