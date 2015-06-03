FactoryGirl.define do

  factory :subscription do
    status 1
    start_date Date.today
    firm

    factory :onemo_subscription do
      category 1
      end_date 30.days.from_now
    end
  end


  factory :payment do
  end

end