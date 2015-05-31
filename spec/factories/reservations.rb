FactoryGirl.define do

	factory :reservation do
		date_reserved "10/05/2015"
		start "15:00"
		duration 2
		court

		factory :direct_booking do
			association :booker, factory: :user
		end

		factory :indirect_booking do
			association :booker, factory: :firm
		end		
	end

end