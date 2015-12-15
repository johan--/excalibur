FactoryGirl.define do

  factory :deal do
  	amount "15000000"
  	crowd 20
  	state "mulai"
  	tender

  	trait :trade do
  	  category "trade"
  	  aqad "murabaha"
  	end

  	# trait :trade do
  	#   category "trade"
  	#   aqad "murabaha"
  	# end

  	trait :starts do
  	  state "mulai"
  	end

    trait :with_tender do 
      association :tender, factory: :consumer_tender
    end   	

    factory :consumer_deal do
  	  category "trade"
  	  aqad "murabaha"
      association :tender, factory: :consumer_tender
    end
  end

end