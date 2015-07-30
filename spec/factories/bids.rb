FactoryGirl.define do

  factory :bid do
  	tender
  	contribution 500000

  	trait :bidder do
  	  bidder
  	end
  end

end