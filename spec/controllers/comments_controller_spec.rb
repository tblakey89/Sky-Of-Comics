require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  let(:comic) { FactoryGirl.create(:comic) }
  let(:comment) { FactoryGirl.create(:comment, commentable: comic) }
  let(:comment2) { FactoryGirl.create(:comment, commentable: comic) }

  describe "#index" do
    it "populates an array of comments" do
      comments = comic.comments.all
      get :index, comic_id: comment.commentable_id
      assigns(:comments).should eq([comment])
    end

    it "renders the index view" do
      get :index, comic_id: comment.commentable_id
      response.should render_template :index
    end
  end

  describe "without signing in" do
    describe "#new" do
      it "requires user to be signed in" do
        get :new, comic_id: comic.id
        response.should redirect_to new_user_session_path
      end
    end

    describe "#create" do
      it "requires user to be signed in" do
        post :create, comic_id: comic.id
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "signed in" do
    let(:user){ FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#new" do
      it "renders the new view" do
        get :new, comic_id: comic.id
        response.should render_template :new
      end
    end

    describe "#create" do
      it "creates a new comment" do
        expect {
          post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:comment, user_id: user.id)
        }.to change(Comment, :count).by(1)
      end

      it "creates a new activity" do
        expect {
          post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:comment, user_id: user.id)
        }.to change(Activity, :count).by(1)
      end

      it "redirects to the commentable page" do
        post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:comment, user_id: user.id)
        response.should redirect_to comic
      end

      describe "invalid comment" do
        it "should not create a comment" do
          expect {
            post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:invalid_comment)
          }.to change(Comment, :count).by(0)
        end

        it "should not create a new activity" do
          expect {
            post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:invalid_comment)
          }.to change(Activity, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, comic_id: comic.id, comment: FactoryGirl.attributes_for(:invalid_comment)
          response.should render_template :new
        end
      end
    end
  end
end
