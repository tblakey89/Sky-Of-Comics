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
    sequence(:name) { |n| "blog#{n}" }
    content "This is the content"
    user
  end

  factory :invalid_blog, class: "Blog" do
    name nil
    content "bad content"
    user
  end

  factory :image do
    sequence(:name) { |n| "image#{n}" }
    description "This is a description"
    location { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.jpg')) }
    user
  end

  factory :invalid_image, class: "Image" do
    name nil
    description "This is a bad image"
    location nil
    user
  end

  factory :comic_image do
    sequence(:page_number) { |n| n }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.jpg')) }
    comic
  end

  factory :invalid_comic_image, class: "ComicImage" do
    sequence(:page_number) { |n| n }
    image nil
    comic
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
