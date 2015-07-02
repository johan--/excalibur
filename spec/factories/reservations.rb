FactoryGirl.define do

	factory :reservation do
		date_reserved {  rand(1..20).days.from_now.to_date.strftime("%d/%m/%Y") }
		start {  "#{rand(1..24)}:00" }
		duration 2
		court

		factory :direct_booking do
			association :booker, factory: :player

			factory :user_booking do
		      after(:create) do |res, evaluator|
		        FactoryGirl.create(:player)
		      end
			end

			factory :paid_booking do
			  transient do
			  	user { FactoryGirl.create(:player) }
			  end

		      after(:create) do |res, evaluator|
		        FactoryGirl.create(:installment, reservation: res,
		        	user: evaluator.user)
		      end				
			end

		end

		factory :indirect_booking do
			association :booker, factory: :firm
		end

	end

end