require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_selector('h2', text: 'Sign in') }
    it { should have_selector('title', text: full_title('Sign in')) }
  end

  describe "signin" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('h2', text: 'Sign in') }
      it { should have_selector('title', text: full_title('Sign in')) }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }

      it { should have_selector('h1', text: 'Sky of Comics') }
      it { should_not have_selector('h2', text: 'Sign in') }
      it { should have_link('Logout', href: destroy_user_session_path) }
      it { should have_selector('title', text: full_title("")) }

      describe "followed by signout" do
        before { click_link "Logout" }

        it { should have_link('Login', href: new_user_session_path) }
      end
    end
  end
end
