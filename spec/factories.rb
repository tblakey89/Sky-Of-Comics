FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "factory#{n}" }
    sequence(:email) { |n| "factory#{n}@factory.com" }
    password "factory1"
    password_confirmation "factory1"
    confirmed_at Time.now
  end

  factory :comic do
    sequence(:name) { |n| "comic#{n}" }
    description "This is a description"
    user
  end
end
