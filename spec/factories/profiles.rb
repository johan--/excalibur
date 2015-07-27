FactoryGirl.define do

  factory :profile do
  	about "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum."

  	factory :company_profile do
  	  category "CompanyProfile"
  	  details { { anno: 2015, founding_size: 4 } }
  	  association :profileable, factory: :team
      
  	  # transient do
  	  # 	email "stub@example.com"
  	  # end

     #  before(:create) do |company_profile, evaluator|
     #     FactoryGirl.create(:business)
     #  end  	  
  	end

  	# trait :profileable do
  	#   profileable
  	# end

    factory :user_profile do
      category "UserProfile"
      details { { last_education: "D3/Sarjana", marital_status: "Menikah" } }
      association :profileable, factory: :user
      
      # transient do
      #   email "stub@example.com"
      # end

     #  before(:create) do |company_profile, evaluator|
     #     FactoryGirl.create(:business)
     #  end     
    end
  end

end