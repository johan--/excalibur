FactoryGirl.define do

  factory :subscription do
    start_date Date.today
    firm

    factory :onemo_subscription do
      category 1
      end_date 30.days.from_now

      factory :active_1_mo do
        state "aktif"
      end
    end

    trait :active do
      state "aktif"
    end

    trait :suspended do
      state "terkunci"
    end

    trait :cancelled do
      state "berhenti"
    end    
  end


  factory :payment do
  end

end