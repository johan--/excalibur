FactoryGirl.define do

  factory :roster do
    team

    factory :member do
      association :rosterable, factory: :user

      factory :active_manager do
        state "aktif"
        role 1
      end

      factory :pending_member do
        state "menunggu konfirmasi"
        role 2
      end
    end

    # factory :document do
    #   role 1
    #   association :rosterable, factory: :team
    # end
  end

end