require 'spec_helper'

describe "ComicPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:comic) { FactoryGirl.create(:comic) }

  before { valid_signin user }

  describe "comic creation" do
    before { visit new_comic_path }

    describe "with invalid information" do
      it { should have_selector("title", text: "New Comic") }

      it "should not create a comic" do
        expect { click_button "Create" }.should_not change(Comic, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Name', with: "test comic1"
        fill_in 'Description', with: "test description"
      end

      it "should create a comic" do
        expect { click_button "Create" }.should change(Comic, :count).by(1)
      end

      describe "add activity to user's profile" do
        before do
          click_button "Create"
          visit user_path(user)
        end
        it { should have_content(user.username + " created a new comic: test comic1") }
      end
    end
  end

  describe "visit a comic page" do
    before { visit comic_path(comic.id) }

    it { should have_selector('h1', text: comic.name) }
    it { should have_selector('title', text: comic.name) }
    it { should have_selector('h3', text: "Comment") }

    describe "a user can enter a comment" do
      before { fill_in 'Content', with: "test content" }

      it "should create a comment" do
        expect { click_button "Create Comment" }.should change(Comment, :count).by(1)
      end

      describe "after clicking create comment" do
        before { click_button "Create Comment" }

        it { should have_selector('h1', text: comic.name) }
        it { should have_selector('p', text: "test content") }

        describe "should create an activity" do
          before { visit user_path(user) }

          it { should have_content(user.username + " commented on " + comic.name) }
        end
      end
    end
  end

  describe "visit the comic index" do
    before { visit comics_path }

    it { should have_selector('h1', text: "All Comics") }
    it { should have_selector('title', text: "Comics") }
  end
end
