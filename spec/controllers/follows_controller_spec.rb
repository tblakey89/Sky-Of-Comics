require 'spec_helper'
describe FollowsController do
  include Devise::TestHelpers

  describe "without signing in" do
    describe "#create" do
      it "requires user to be signed in" do
        post :create
        response.should redirect_to new_user_session_path
      end
    end

    describe "#destroy" do
      it "requires user to be signed in" do
        delete :destroy, id: "1"
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with signing in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#create" do
      it "creates a new follows relationship" do
        expect {
          post :create, follow: { followed_id: user2.id }
        }.to change(Follow, :count).by(1)
      end

      it "creates two new activities" do
        expect {
          post :create, follow: { followed_id: user2.id }
        }.to change(Activity, :count).by(2)
      end

      it "should redirect to followed user's page" do
        post :create, follow: { followed_id: user2.id }
        response.should redirect_to user2
      end

      describe "when trying to follow themself" do
        it "does not create a new follow relationship" do
          expect {
            post :create, follow: { followed_id: user.id }
          }.to change(Follow, :count).by(0)
        end

        it "does not create any activities" do
          expect {
            post :create, follow: { followed_id: user.id }
          }.to change(Activity, :count).by(0)
        end

        it "should redirect to current user's page" do
          post :create, follow: { followed_id: user.id }
          response.should redirect_to user
        end
      end

      describe "when trying to follow a non-existant user" do
        it "should not create a new follow relationship" do
          expect {
            post :create, follow: { followed_id: 0 }
          }.to change(Follow, :count).by(0)
        end

        it "should not create any activities" do
          expect {
            post :create, follow: { followed_id: 0 }
          }.to change(Activity, :count).by(0)
        end

        it "should redirect to the current user's profile" do
          post :create, follow: { followed_id: 0 }
          response.should redirect_to user
        end
      end
    end

    describe "#destroy" do
      before :each do
        user.follows.create(followed_id: user2.id)
        @follow = Follow.find_by_followed_id(user2.id)
      end

      it "destroys the follows relationship" do
        expect {
          delete :destroy, id: @follow.id
        }.to change(Follow, :count).by(-1)
      end

      it "redirects to the user" do
        delete :destroy, id: @follow.id
        response.should redirect_to user2
      end
    end
  end
end
