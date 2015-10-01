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
  	  category "Individu"
      price 500000000
      address "Jl. Cipete 10 No. 90 RT 10 RW 11 Cilandak, Jakarta Selatan"
      intent "Tempat Tinggal"
      tangible "Rumah Tunggal"
      use_case "Pembelian"
      published true

      factory :con_tender do
        transient do
          consumer { FactoryGirl.create(:consumer) }
        end

        tenderable { consumer }
      end      
  	end

    trait :draft do
      published false
    end

    trait :musharakah do
      aqad "musyarakah mutanaqishah"
      target 400000000
    end

    trait :murabahah do
      aqad "murabahah"
    end

    trait :tenderable do
      tenderable
    end 
  end	

end