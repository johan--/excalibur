FactoryGirl.define do
	factory :house do
		price 300000000
		category "rumah"
		state "available"
		anno 2015
		sequence(:address) { |n| "Jl. Cipete 10 No. #{n+13} RT 10 RW 11 Cilandak"}
		city "Jakarta Selatan"
		association :publisher, factory: :developer
		vacant "yes"
		for_sale "yes"
		for_rent "no"

	    trait :by_developer do 
	      association :publisher, factory: :business
	    end 		

	    trait :with_developer do
	      after(:build) do |house|
	        house.publisher = FactoryGirl.create :developer
	      end  
	    end

	    trait :full_detail do
	      bedrooms 3
	      bathrooms 1
	      level 1
	      garages 1
	      greenery true
	      lot_size 100
	      property_size 90
		end
	end	
end