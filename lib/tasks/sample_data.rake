namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_follows
  end

  def make_users
    User.create!(username: "exampleuser", email: "example@email.com", password: "testpassword", password_confirmation: "testpassword")
    99.times do |n|
      username = Faker::Name.first_name + Faker::Name.last_name
      email = "example#{n}@example.com"
      password = "testpassword"
      User.create!(username: username, email: email, password: password, password_confirmation: password)
    end
  end

  def make_follows
    users = User.all
    user = users.first
    followed_users = users[2..45]
    followers = users[3..30]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
  end
end
