FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Blog Post No.#{n}"}
    content_md "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor"
    topic "test dummy"
    user

    factory :draft do
    	draft true
    end
  end

end
