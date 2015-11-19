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
  end

end