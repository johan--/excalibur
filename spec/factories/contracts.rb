FactoryGirl.define do

  factory :contract do
    association :tender, factory: :tender
    begin_at { Date.now }

    factory :musharaka_contract do
      type "Musharaka"
      aqad "musharaka mutanaqishah"
    end
  end

end