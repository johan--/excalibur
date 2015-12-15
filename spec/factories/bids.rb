FactoryGirl.define do

  factory :bid do
  	tender
  	# contribution 500000000
  	shares 1000
  	summary "lorem ipsum dolor casus molar"

  	trait :bidder do
  	  bidder
  	end

  	trait :confirmed do
  	  state "confirmed"
  	end

    trait :nameless do
      before(:create) do |bid|
        bid.bidder = FactoryGirl.create :financier
      end      
    end

    trait :quarter do
      shares 250
    end
  end

end