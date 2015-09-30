FactoryGirl.define do

  factory :subscriber do
    # transient do
    #   user { FactoryGirl.create(:client) }
    # end

    email "foobarbaz@gmail.com"
    # name { user.name }

    factory :beta_user do
      category "landing"
    end

    factory :blog_subscriber do
      category "blog"
    end    
  end

end