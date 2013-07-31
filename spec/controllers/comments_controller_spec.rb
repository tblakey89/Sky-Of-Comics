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
  end
end
