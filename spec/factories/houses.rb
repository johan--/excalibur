FactoryGirl.define do
	factory :house do
		association :publisher, factory: :user

		trait :place do
			sequence(:address) { |n| "Cipete 10 No. #{n+13} RT 10 RW 11 Cilandak"}
			city "Jakarta Selatan" 
			province "DKI Jakarta"
		end
	    trait :characteristics do
	      category "rumah"
	      bedrooms 3
	      bathrooms 1
	      level 1
	      garages 1
	      lot_size 100
	      property_size 90
		end				
		
		trait :situations do
			vacant "yes"
			for_sale "yes"
			for_rent "no"
			price 300000000
			anno 2015
			mortgage_period_left 0
		end

		trait :owned do
		  vacant "no"
		  for_sale "yes"
		  for_rent "no"
		end

		factory :complete_house do
		  place
		  characteristics
		  situations
		  form_step 'done'

		  factory :owned_house do
		    owned
		  end
		end


	    # after(:create) do |house|
	    #   house.stocks << FactoryGirl.create :stock
	    # end

	    trait :by_developer do 
	      association :publisher, factory: :business
	    end 		

	    trait :with_developer do
	      after(:build) do |house|
	        house.publisher = FactoryGirl.create :developer
	      end
	    end
	end	

	factory :stock do
   	  association :holder, factory: :developer
      association :house, factory: :house, strategy: :build
      category "ownership"
      initial 'yes'
      tradeable true
      price 300000
      volume 1000
      state "full"
      # after(:build) do |stock|
      # 	house = FactoryGirl.create :house
      #   stock.house = house
      #   stock.holder = house.publisher
      #   stock.volume = 1000
      # 	stock.price = house.price / 1000
      #   # stock
      # end      
	end
end