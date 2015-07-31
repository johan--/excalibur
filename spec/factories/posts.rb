FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Blog Post No.#{n}"}
    content_md "Lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor lorem ipsum dolor"
    user

    trait :draft do
      draft true
    end

    trait :dummy_keywords do
      keywords { { topic: "test dummy", tags: ["test", "lorem"] } }
    end

    factory :post_with_user do
	  transient do
	  	author { FactoryGirl.create(:entrepreneur) }
	  end

	  user { author }
    end
  end

end
