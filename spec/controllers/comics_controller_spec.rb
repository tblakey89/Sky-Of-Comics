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

  describe "without signing in" do
    describe "#create" do
      it "requires user to be signed in" do
        post :create
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with signing in" do
    let(:user){ FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#create" do
      it "creates a new comic" do
        expect {
          post :create, comic: FactoryGirl.attributes_for(:comic)
        }.to change(Comic, :count).by(1)
      end

      it "creates a new activity" do
        expect {
          post :create, comic: FactoryGirl.attributes_for(:comic)
        }.to change(Activity, :count).by(1)
      end

      it "redirects to the new comic" do
        post :create, comic: FactoryGirl.attributes_for(:comic)
        response.should redirect_to Comic.last
      end

      describe "with invalid information" do
        it "does not create a new comic" do
          expect {
            post :create, comic: FactoryGirl.attributes_for(:invalid_comic)
          }.to change(Comic, :count).by(0)
        end

        it "does not create a new activity" do
          expect {
            post :create, comic: FactoryGirl.attributes_for(:invalid_comic)
          }.to change(Activity, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, comic: FactoryGirl.attributes_for(:invalid_comic)
          response.should render_template :new
        end
      end
    end
  end

  describe "#show" do
    let(:the_comic) { FactoryGirl.create(:comic) }
    let(:the_comment) { FactoryGirl.create(:comment, commentable: the_comic) }

    it "assigns a comic" do
      get :show, id: the_comic.id
      assigns(:comic).should eq(the_comic)
    end

    it "renders the show view" do
      get :show, id: the_comic.id
      response.should render_template :show
    end
  end
end
