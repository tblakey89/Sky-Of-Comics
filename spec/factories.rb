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

  factory :invalid_comic, class: "Comic"  do
    name nil
    description "bad comic"
    user
  end

  factory :blog do
    sequence(:title) { |n| "blog#{n}" }
    content "This is the content"
    user
  end

  factory :invalid_blog, class: "Blog" do
    title nil
    content "bad content"
    user
  end

  factory :comment do
    content "Test123"
    user
    association :commentable, factory: :comic
  end

  factory :invalid_comment, class: "Comment" do
    content nil
    user
    association :commentable, factory: :comic
  end
end
