FactoryGirl.define do

  factory :tender do
    summary "Lorem ipsum dolor cassus"

	  category "User"
    price 500000000
    address "Jl. Cipete 10 No. 90 RT 10 RW 11 Cilandak, Jakarta Selatan"
    intent "tempat tinggal"
    tangible "rumah tunggal"
    use_case "pembelian"
    own_capital 30
    maturity 8
    published true
    state "processing"
      # trait :with_bid do
      #   transient do
      #     consumer { FactoryGirl.create(:consumer) }
      #   end

      #   tenderable { consumer }
      # end
    trait :completed do
      state "success"

      transient do
        count 4
      end

      # after_create do |tender, evaluator|
      #   FactoryGirl.create_list(:bid, 4, :nameless, :confirmed, :quarter, tender: tender)
      # end

      after(:build) do |tender|
        FactoryGirl.create(:bid, :nameless, :confirmed, :tender => tender, shares: 1000)
      end      
    end      

    trait :with_tenderable do 
      association :tenderable, factory: :client
    end 

    factory :consumer_tender do
      association :tenderable, factory: :client
    end

    trait :draft do
      published false
    end

    trait :musharakah do
      aqad "musyarakah"
    end

    trait :murabahah do
      aqad "murabahah"
    end

    trait :tenderable do
      tenderable
    end

    trait :processing do
      state "processing"
    end 
  end	

end