require 'spec_helper'

describe ComicImagesController do
  include Devise::TestHelpers
  let(:comic) { FactoryGirl.create(:comic) }

  describe "without signing in" do
    describe "#create" do
      it "requires user to be signed in" do
        post :create, comic_id: comic.id
        response.should redirect_to new_user_session_path
      end
    end

    describe "#new" do
      it "requires the user to be signed in" do
        get :new, comic_id: comic.id
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with sigining in" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "#create" do
      it "creates a new comic_image" do
        expect {
          post :create, comic_id: comic.id, comic_image: FactoryGirl.attributes_for(:comic_image) }.to change(ComicImage, :count).by(1)
      end

      it "redirects to the comic page" do
        post :create, comic_id: comic.id, comic_image: FactoryGirl.attributes_for(:comic_image)
        response.should redirect_to comic
      end

      describe "with invalid comic image" do
        it "does not create a new image" do
          expect {
            post :create, comic_id: comic.id, comic_image: FactoryGirl.attributes_for(:invalid_comic_image)
          }.to change(ComicImage, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, comic_id: comic.id, comic_image: FactoryGirl.attributes_for(:invalid_comic_image)
          response.should render_template :new
        end
      end
    end

    describe "#new" do
      it "renders the new page" do
        get :new, comic_id: comic.id
        response.should render_template :new
      end
    end
  end
end
