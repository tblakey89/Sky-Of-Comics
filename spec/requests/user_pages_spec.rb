require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end

  describe "signup" do
    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }
    describe "with invalid information" do
      it "should not create an account" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: "exampleuser89"
        fill_in "Email", with: "example89@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
      end

      it "should create a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    let(:user){ FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.username) }
    it { should have_selector('title', text: user.username) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_signin(user)
      visit edit_user_registration_path(user)
    end

    describe "page" do
      it { should have_selector('title', text: "Edit Profile") }
      it { should have_selector('h2', text: "Edit User") }
    end

    describe "with invalid information" do
      before do
        fill_in "Email", with: ""
        click_button "Update"
      end

      it { should have_selector('h2', text: 'errors') }
    end

    describe "with valid information" do
      let(:email) { "new@new.com" }
      let(:password) { "newpassword" }
      before do
        fill_in "Email", with: email
        fill_in "Password", with: password
        fill_in "Password confirmation", with: password
        fill_in "Current password", with: user.password
        click_button "Update"
      end

      it { should have_selector('p.notice', text: "You updated your account successfully.") }
      it { should have_selector('title', text: full_title("")) }
    end
  end

  describe "index" do
    before do
      valid_signin FactoryGirl.create(:user)
      FactoryGirl.create(:user, username: "username1", email: "email@email.com")
      FactoryGirl.create(:user, username: "username2", email: "email2@email.com")
      visit users_path
    end

    it { should have_selector('title', text: "Users") }
    it { should have_selector('h1', text: "All Users") }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.username)
      end
    end
  end
end
