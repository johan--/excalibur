FactoryGirl.define do

  factory :tender do
    summary "Lorem ipsum dolor cassus"

  	factory :retail do
  	  category "BizPartnership"
  	  target "15000000"

      # factory :biz_tender do
      #   tenderable
      # end

      # factory :tender_with_biz do
      #   transient do
      #     applicant { FactoryGirl.create(:business) }
      #   end

      #   tenderable { applicant }
      # end
  	end

  	factory :consumer_tender do
  	  category "ConsumerFinancing"
  	  target "250000000"
      association :tenderable, factory: :user

      factory :con_tender do
        transient do
          applicant { FactoryGirl.create(:consumer) }
        end

        tenderable { applicant }
      end      
  	end

    trait :musharakah do
      aqad "musharakah"
    end

    trait :mudharabah do
      aqad "mudharabah"
    end

    trait :murabahah do
      aqad "murabahah"
    end

    trait :tenderable do
      tenderable
    end 
  end	

end