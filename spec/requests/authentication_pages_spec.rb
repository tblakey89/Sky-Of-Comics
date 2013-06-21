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

  describe "authorization" do
    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the following page" do
          before { visit user_following_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the followers page" do
          before { visit user_followers_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end
      end

      describe "in the follows controller" do
        describe "submitting to the create action" do
          before { post follows_path }
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "submitting to the destroy action" do
          before { delete follow_path(1) }
          specify { response.should redirect_to(new_user_session_path) }
        end
      end

      describe "in the comics controller" do
        describe "submitting to the create action" do
          before { visit new_comic_path }
          it { should have_selector('title', text: "Sign in") }
        end
      end
    end
  end
end
