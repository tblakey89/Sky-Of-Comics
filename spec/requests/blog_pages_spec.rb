require 'spec_helper'

describe "BlogPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:blog) { FactoryGirl.create(:blog) }

  before { valid_signin user }

  describe "blog creation" do
    before { visit new_blog_path }

    it { should have_selector("title", text: "New Blog") }

    describe "with invalid information" do
      it "should not create a blog" do
        expect { click_button "Create" }.should_not change(Blog, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Title', with: "Test Title"
        fill_in 'Content', with: "test content"
      end

      it "should create a blog post" do
        expect { click_button "Create" }.should change(Blog, :count).by(1)
      end
    end
  end

  describe "visit a blog page" do
    before { visit blog_path(blog.id) }

    it { should have_selector('h1', text: blog.title) }
    it { should have_selector('title', text: blog.title) }
    it { should have_selector('h3', text: "Comment") }

    describe "a user can enter a comment" do
      before { fill_in 'Content', with: "test content" }

      it "create a comment" do
        expect { click_button "Create Comment" }.should change(Comment, :count).by(1)
      end

      describe "after clicking create comment" do
        before { click_button "Create Comment" }

        it { should have_selector('h1', text: blog.title) }
        it { should have_selector('p', text: "test content") }
      end
    end
  end

  describe "visit the blog index" do
    before { visit blogs_path }

    it { should have_selector('h1', text: "All Blogs") }
    it { should have_selector('title', text: "Blogs") }
  end
end
