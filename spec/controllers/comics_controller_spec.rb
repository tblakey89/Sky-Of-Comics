require 'spec_helper'
describe ComicsController do
  include Devise::TestHelpers

  describe "#index" do
    it "populates an array of comics" do
      Comic.stub(all: [comic = stub])
      get :index
      assigns(:comics).should eq([comic])
    end

    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "#create" do
    it "requires user to be signed in" do
      post :create
      response.should redirect_to new_user_session_path
    end
  end

  describe "#show" do

    it "assigns a comic" do
      Comic.stub(:find).and_return(comic = stub)
      get :show, id: "1"
      assigns(:comic).should eq(comic)
    end

    it "renders the show view" do
      Comic.stub(:find).and_return(comic = stub)
      get :show, id: "1"
      response.should render_template :show
    end
  end
end
