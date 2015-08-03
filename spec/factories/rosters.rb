FactoryGirl.define do

  factory :roster do
    # team

    factory :member do
      # association :rosterable, factory: :user

      factory :active_manager do
        role 1
      end

      factory :pending_member do
        state "menunggu konfirmasi"
        role 2
      end

      trait :with_user do
        before :create do |roster|
          user { FactoryGirl.create :entrepreneur }
        end

        rosterable_type { user.class.name }
        rosterable_id { user.id }
      end

      trait :team do
        team
      end
    end

    # factory :document do
    #   role 1
    #   association :rosterable, factory: :team
    # end
  end

end