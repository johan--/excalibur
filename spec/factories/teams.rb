FactoryGirl.define do

  factory :team do
    factory :firm do
      type "Firm"
      sequence(:name) { |n| "Firm #{n}" }
    end

    factory :business do
      type "Business"
      sequence(:name) { |n| "Biz #{n}" }
    end

    trait :starter_email do
      starter_email
    end
  end

  # factory :venue do
  #   sequence(:name) { |n| "Arena #{n}" }
  #   # sequence(:address) { |n| "Jl. Arena No. #{n}" } 
  #   sequence(:phone) { |n| "08135555#{n}" } 
  #   firm

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