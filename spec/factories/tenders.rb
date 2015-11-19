FactoryGirl.define do

  factory :tender do
    summary "Lorem ipsum dolor cassus"

  	factory :retail do
  	  category "BizPartnership"
  	  target "15000000"

      trait :with_biz do
        transient do
          business { FactoryGirl.create(:business) }
        end

        tenderable { business }
      end
  	end

  	factory :consumer_tender do
  	  category "User"
      price 500000000
      address "Jl. Cipete 10 No. 90 RT 10 RW 11 Cilandak, Jakarta Selatan"
      intent "tempat tinggal"
      tangible "rumah tunggal"
      use_case "pembelian"
      own_capital 30
      maturity 8
      published true

      # trait :with_bid do
      #   transient do
      #     consumer { FactoryGirl.create(:consumer) }
      #   end

      #   tenderable { consumer }
      # end      
  	end

    trait :draft do
      published false
    end

    trait :musharakah do
      aqad "musyarakah"
    end

    trait :murabahah do
      aqad "murabahah"
    end

    trait :tenderable do
      tenderable
    end

    trait :processing do
      state "processing"
    end 
  end	

end