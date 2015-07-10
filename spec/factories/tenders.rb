FactoryGirl.define do

  factory :tender do

  	factory :vehicle_tender do
  	  category "kendaraan"
  	  total "15000000"
  	end

  	factory :house_tender do
  	  category "rumah"
  	  total "250000000"
  	end

  	factory :gadget_tender do
  	  category "elektronik"
  	  total "5000000"
  	end

  	factory :education_tender do
  	  category "pendidikan"
  	  total "10000000"
  	end  	
  end	

end