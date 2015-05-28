FactoryGirl.define do

  factory :firm do
    sequence(:name) { |n| "Firm #{n}" }
    sequence(:phone) { |n| "0111111#{n}" }
    sequence(:address) { |n| "Jl. Example No. #{n}" } 
    city "DKI Jakarta"
    # factory :one_venue_firm do
    #   transient do
    #     year 2015
    #   end

    #   after(:create) do |firm, evaluator|
    #     FactoryGirl.create(:income_statement, firm: firm)
    #     FactoryGirl.create(:cash_flow, firm: firm)
    #   end
    # end
  end
    
  trait :capital do
    city "DKI Jakarta"
    sequence(:address) { |n| "Jl. Ibukota No. #{n}" } 
  end

  trait :satellite do
    city "Bekasi"
    sequence(:address) { |n| "Jl. Satelit No. #{n}" } 
  end

  factory :venue do
    sequence(:name) { |n| "Arena #{n}" }
    # sequence(:address) { |n| "Jl. Arena No. #{n}" } 
    sequence(:phone) { |n| "08135555#{n}" } 
    firm

    factory :capital_venue do
      province "DKI Jakarta"
      city "Jakarta Selatan"
      sequence(:address) { |n| "Jl. Ibukota No. #{n}" }       

      before(:create) do |venue, evaluator|
        FactoryGirl.create(:firm)
      end
    end

    factory :satellite_venue do
      province "Banten"
      city "Bekasi"
      sequence(:address) { |n| "Jl. Satelit No. #{n}" } 

      before(:create) do |venue, evaluator|
        FactoryGirl.create(:firm)
      end
    end

    transient do
      number_of_court 4
    end   

      after(:create) do |venue, evaluator|
        FactoryGirl.create(:court, venue: venue)
      end    
  end


  factory :court do
    sequence(:name) { |n| "Court #{n}" }
    price 150000
    unit "Jam"
    category 1
    venue
  end

end