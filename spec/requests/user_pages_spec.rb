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
end
