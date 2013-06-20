require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_selector('title', text: 'Sky of Comics') }
    it { should have_selector('h1', text: 'Sky of Comics') }
    it { should_not have_selector('title', text: 'Home') }

    describe "For signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        valid_signin user
        visit root_path
      end

      it { should have_selector('strong', text: user.username) }

      describe "following/follower counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: user_following_path(user)) }
        it { should have_link("1 follower", href: user_followers_path(user)) }
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
    it { should have_selector('title', text: 'Sky of Comics | Help') }
  end

  describe "About Page" do
    before { visit about_path }
    it { should have_selector('title', text: 'Sky of Comics | About') }
  end
end
