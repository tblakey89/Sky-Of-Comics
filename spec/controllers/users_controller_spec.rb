require 'spec_helper'
describe UsersController do
  include Devise::TestHelpers

  describe "#index" do
    it "populates an array of users" do
      User.stub(all: [user = stub])
      get :index
      assigns(:users).should eq([user])
    end

    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "#show" do
    it "assigns a user" do
      User.stub(:find).with("1").and_return(user = stub)
      get :show, id: "1"
      assigns(:user).should eq(user)
    end

    it "renders the show view" do
      User.stub(:find).with("1").and_return(user = stub)
      get :show, id: "1"
      response.should render_template :show
    end
  end

  describe '#followers' do
    it "requires the user to be signed in" do
      get :followers, user_id: "1"
      response.should redirect_to new_user_session_path
    end
  end

  describe "#following" do
    it "requires the user to be signed in" do
      get :following, user_id: '1'
      response.should redirect_to new_user_session_path
    end
  end
end
