require 'spec_helper'
describe FollowsController do
  include Devise::TestHelpers

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
