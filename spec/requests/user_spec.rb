require 'spec_helper'

describe User do
  before { @user = User.new(username: "exampleuser", email: "user@example.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }

  describe "when password is not present" do
    before { @user.password = "" }
    it { should_not be_valid }
  end

  describe "when password confirm is not present" do
    before { @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is not an email" do
    before { @user.email = "helloworld" }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 52 }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

  describe "user with same email" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.username = "othername"
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "user with same username" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.email = "other@other.com"
      user_with_same_username.save
    end

    it { should_not be_valid }
  end
end
