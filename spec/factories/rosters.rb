FactoryGirl.define do

  factory :roster do
    factory :member do
      association :rosterable, factory: :user

      # factory :active_manager do
      #   role 1
      # end

      # factory :pending_member do
      #   state "pending"
      #   role 2
      # end

      factory :deal_client do
        role 0
      end

      trait :with_user do
        transient do
          user { FactoryGirl.create :entrepreneur }
        end

        rosterable { user }
      end
    end

    # factory :document do
    #   role 1
    #   association :rosterable, factory: :team
    # end

    trait :teamable do
      teamable
    end
  end

end