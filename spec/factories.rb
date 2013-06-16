FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "factory#{n}" }
    sequence(:email) { |n| "factory#{n}@factory.com" }
    password "factory1"
    password_confirmation "factory1"
  end
end
