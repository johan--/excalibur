FactoryGirl.define do

  factory :roster do
    # before(:create) do |roster, evaluator|
    #   FactoryGirl.create(:manager)
    # end

    user

    factory :active_manager do
      role 0
      association :rosterable, factory: :firm
    end

    # factory :user do
    #   role 1
    #   association :rosterable, factory: :team
    # end
  end

end