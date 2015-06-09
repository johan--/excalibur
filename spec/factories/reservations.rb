FactoryGirl.define do

	factory :reservation do
		# sequence(:date_reserved) { |n| n.days.from_now.to_date }
		date_reserved {  rand(1..20).days.from_now.to_date }
		# sequence(:start) { |n| "#{rand(n)}:00" }
		start {  "#{rand(1..24)}:00" }
		# start "15:00"
		duration 2
		court

		factory :direct_booking do
			association :booker, factory: :player

			factory :user_booking do
		      after(:create) do |res, evaluator|
		        FactoryGirl.create(:player)
		      end
			end
		end

		factory :indirect_booking do
			association :booker, factory: :firm
		end

		# trait :confirmed do
		#     after(:create) do |res, evaluator|
		# 		res.transition_to!		        
		#     end			
		# end 

	end

end