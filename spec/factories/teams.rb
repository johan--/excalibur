FactoryGirl.define do

  factory :team do
    factory :firm do
      type "Firm"
      sequence(:name) { |n| "Firm #{n}" }
    end

    trait :starter_email do
      starter_email
    end
    # trait :with_subscription do
    #   after(:create) do |firm, evaluator|
    #     FactoryGirl.create(:active_1_mo, firm: firm)
    #   end            
    # end        
  end

  # factory :venue do
  #   sequence(:name) { |n| "Arena #{n}" }
  #   # sequence(:address) { |n| "Jl. Arena No. #{n}" } 
  #   sequence(:phone) { |n| "08135555#{n}" } 
  #   firm

  #   factory :capital_venue do
  #     province "DKI Jakarta"
  #     city "Jakarta Selatan"
  #     sequence(:address) { |n| "Jl. Ibukota No. #{n}" }       

  #     factory :cap_venue_with_firm do
  #       before(:create) do |venue, evaluator|
  #         FactoryGirl.create(:firm)
  #       end
  #     end
  #   end

  #   factory :satellite_venue do
  #     province "Banten"
  #     city "Bekasi"
  #     sequence(:address) { |n| "Jl. Satelit No. #{n}" } 

  #     before(:create) do |venue, evaluator|
  #       FactoryGirl.create(:firm)
  #     end
  #   end

  #   transient do
  #     number_of_court 4
  #   end   

  #   after(:create) do |venue, evaluator|
  #     FactoryGirl.create_list(:court, evaluator.number_of_court, venue: venue)
  #   end    
  # end


end