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
      it "does not create an account" do
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

      it "creates a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "sending emails" do
        before { click_button submit }
        it "sends an email to the signed up user" do
          last_email.to.should include("example89@example.com")
        end
      end
    end
  end

  describe "profile page" do
    let(:user){ FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.username) }
    it { should have_selector('title', text: user.username) }

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { valid_signin user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "increments the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "increments the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end

        describe "adds to both users' activity feeds" do
          before { click_button "Follow" }
          it { should have_content(other_user.username + " was followed by " + user.username) }

          describe "visiting user's own profile" do
            before { visit user_path(user) }
            it { should have_content(user.username + " followed " + other_user.username) }
          end
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "decrements the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "decrements the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
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

    it "displays the users index path" do
      current_path.should == users_path
    end

    it { should have_selector('h1', text: "All Users") }

    it "lists each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.username)
      end
    end
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        valid_signin user
        visit user_following_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_link(other_user.username, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        valid_signin other_user
        visit user_followers_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_link(user.username, href: user_path(user)) }
    end
  end
end
