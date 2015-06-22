FactoryGirl.define do

  factory :relationship do
  	association :follower, factory: :user

  	factory :favorite do
  		association :followed, factory: :venue
  	end

  	factory :follow do
  		association :followed, factory: :user
  	end
  end

end