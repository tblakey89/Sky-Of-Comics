require 'spec_helper'

describe "ImagePages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:image) { FactoryGirl.create(:image) }

  before { valid_signin user }

  describe "image creation" do
    before { visit new_image_path }

    it { should have_selector("title", text: "New Image") }

    describe "with invalid information" do
      it "should not creat an image" do
        expect { click_button "Create" }.should_not change(Image, :count)
      end
    end
  end

  describe "visit an image page" do
    before { visit image_path(image.id) }

    it { should have_selector('h1', text: image.name) }
    it { should have_selector('title', text: image.name) }
    it { should have_selector('h3', text: "Comment") }

    describe "a user can enter a comment" do
      before { fill_in 'Content', with: "test content" }

      it "creates a comment" do
        expect { click_button "Create Comment" }.should change(Comment, :count).by(1)
      end

      describe "after clicking create comment" do
        before { click_button "Create Comment" }

        it { should have_selector('h1', text: image.name) }
        it { should have_selector('p', text: "test content") }

        describe "should create an activity" do
          before { visit user_path(user) }

          it { should have_content(user.username + " commented on " + image.name) }
        end
      end
    end
  end

  describe "visit the image index" do
    before { visit images_path }

    it { should have_selector('h1', text: "All Images") }
    it { should have_selector('title', text: "Images") }
  end
end
