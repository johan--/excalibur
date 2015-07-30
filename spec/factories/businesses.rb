FactoryGirl.define do

  factory :business do
    sequence(:name) { |n| "Biz #{n}" }
    profile { {anno: 2015, founding_size: 4} }

    trait :with_starter do
      transient do
        user { FactoryGirl.create(:entrepreneur) }
      end

      starter_email { user.email }
    end

    # trait :with_musharakah_tenders do
    #   after :create do |biz|
    #     FactoryGirl.create_list :biz_tender, 3, :tenderable => biz, :musharakah
    #   end
    # end    
  end


end