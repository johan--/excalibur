FactoryGirl.define do

  factory :invoice do
  	deadline { 7.days.from_now }

  	factory :funding_invoice do
  	  category "funding"
      association :invoicable, factory: :bid_for_purchase_musharaka
      association :recipient, factory: :user
      # amount {  }
  	end
  end

  factory :payment do
  	association :sender, factory: :user
  	invoice

  	factory :full_payment do
  	  full
  	  clean
  	end

  	factory :full_virgin_payment do
  	  full
  	end
  	
  	trait :full do
  	  before(:create) do |payment|
  	  	payment.amount = payment.invoice.amount
  	  end  		
  	end

  	trait :clean do
  	  after(:create) do |payment|
  	  	payment.confirm_payment!
  	  end  		
  	end
  end

end