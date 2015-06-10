FactoryGirl.define do

	factory :installment do
		pay_code { "kode#{rand(1..99)}nomor" }
		pay_day Date.today
		pay_time {  "#{rand(1..24)}:00" }
		total 50000
		reservation
		user

		trait :with_booking do
		    before(:create) do |ins, evaluator|
				FactoryGirl.create(:user_booking)
		    end			
		end 

	end

end