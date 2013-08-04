require 'spec_helper'
describe ImagesController do
  include Devise::TestHelpers

  describe "#index" do
    it "populates an array of blogs" do
      Image.stub(all: [image = stub])
      get :index
      assigns(:images).should eq([image])
    end

    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "#show" do
    let(:the_image) { FactoryGirl.create(:image) }
    let(:the_comment) { FactoryGirl.create(:comment, commentable: the_image) }

    it "assigns an image" do
      get :show, id: the_image.id
      assigns(:image).should eq(the_image)
    end

    it "renders the show view" do
      get :show, id: the_image.id
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
      it "requires the user to be signed in" do
        get :new
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with signing in" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#create" do
      it "creates a new image" do
        expect {
          post :create, image: FactoryGirl.attributes_for(:image)
        }.to change(Image, :count).by(1)
      end

      it "creates a new activity" do
        expect {
          post :create, image: FactoryGirl.attributes_for(:image)
        }.to change(Activity, :count).by(1)
      end

      it "redirects to the new image" do
        post :create, image: FactoryGirl.attributes_for(:image)
        response.should redirect_to Image.last
      end

      describe "with invalid information" do
        it "does not create a new image" do
          expect {
            post :create, image: FactoryGirl.attributes_for(:invalid_image)
          }.to change(Image, :count).by(0)
        end

        it "does not create a new activity" do
          expect {
            post :create, image: FactoryGirl.attributes_for(:invalid_image)
          }.to change(Activity, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, image: FactoryGirl.attributes_for(:invalid_image)
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
