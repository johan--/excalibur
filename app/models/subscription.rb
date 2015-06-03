class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :firm
  has_many	 :payments

  
end
