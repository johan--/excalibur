FactoryGirl.define do

  factory :roster do
    user

    factory :active_manager do
      state "aktif"
      role 1
      association :rosterable, factory: :firm
    end

    factory :pending_member do
      state "menunggu konfirmasi"
      role 2
      association :rosterable, factory: :firm
    end
    # factory :user do
    #   role 1
    #   association :rosterable, factory: :team
    # end
  end

end