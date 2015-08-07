FactoryGirl.define do

  factory :tender do
    summary "Lorem ipsum dolor cassus"

  	factory :retail do
  	  category "BizPartnership"
  	  target "15000000"

      # factory :biz_tender do
      #   tenderable
      # end

      trait :with_biz do
        transient do
          business { FactoryGirl.create(:business) }
        end

        tenderable { business }
      end
  	end

  	factory :consumer_tender do
  	  category "ConsumerFinancing"
  	  target "5000000"

      factory :con_tender do
        transient do
          consumer { FactoryGirl.create(:consumer) }
        end

        tenderable { consumer }
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