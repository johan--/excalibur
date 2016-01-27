FactoryGirl.define do

  factory :comment do
  	# user
  	body_md "Cech almunia lehmann seaman sczeczny fabianski"

  	factory :post_comment do
  	  association :commentable, factory: :post
  	end

  	trait :with_user do
      transient do
        author { FactoryGirl.create :client }
      end

      user { author }
  	end

  	trait :user do
  	  user
  	end
  end

end