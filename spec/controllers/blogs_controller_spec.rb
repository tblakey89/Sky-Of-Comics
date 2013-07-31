require 'spec_helper'
describe BlogsController do
  include Devise::TestHelpers

  describe "#index" do
    it "populates an array of blogs" do
      Blog.stub(all: [blog = stub])
      get :index
      assigns(:blogs).should eq([blog])
    end

    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "#show" do
    let(:the_blog) { FactoryGirl.create(:blog) }
    let(:the_comment) { FactoryGirl.create(:comment, commentable: the_blog) }

    it "assigns a blog" do
      get :show, id: the_blog.id
      assigns(:blog).should eq(the_blog)
    end

    it "renders the show view" do
      get :show, id: the_blog.id
      response.should render_template :show
    end
  end

  describe "without signing in" do
    describe "#create" do
      it "requires user to be signed in" do
        post :create
        response.should redirect_to new_user_session_path
      end
    end

    describe "#new" do
      it "requires user to be signed in" do
        get :new
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with signing in" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#create" do
      it "creates a new blog" do
        expect {
          post :create, blog: FactoryGirl.attributes_for(:blog)
        }.to change(Blog, :count).by(1)
      end

      it "redirects to the new blog" do
        post :create, blog: FactoryGirl.attributes_for(:blog)
        response.should redirect_to Blog.last
      end

      describe "with invalid information" do
        it "does not create a new blog" do
          expect {
            post :create, blog: FactoryGirl.attributes_for(:invalid_blog)
          }.to change(Blog, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, blog: FactoryGirl.attributes_for(:invalid_blog)
          response.should render_template :new
        end
      end
    end

    describe "#new" do
      it "should render the new view" do
        get :new
        response.should render_template :new
      end
    end
  end
end
