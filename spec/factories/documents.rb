FactoryGirl.define do

  factory :document do
  	image_id "loremipsumdolor"
    doc_type "Kartu Keluarga"

  	trait :owner do
  	  bidder
  	end

  	# trait :confirmed do
  	#   state "confirmed"
  	# end
  end

end