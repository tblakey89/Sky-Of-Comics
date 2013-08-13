require 'spec_helper'

describe PrivateMessagesController do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:private_message) { FactoryGirl.create(:private_message, sender: user, recipient: user2) }

  describe "without signing in" do
    describe "#create" do
      it "requires user to be signed in" do
        post :create, user_id: user2.id, private_message: FactoryGirl.attributes_for(:private_message, sender: user2, recipient: user)
        response.should redirect_to new_user_session_path
      end
    end

    describe "#index" do
      it "requires the user to be signed in" do
        get :index, user_id: user2.id
        response.should redirect_to new_user_session_path
      end
    end

    describe "#show" do
      it "requires the user to be signed in" do
        get :show, user_id: user2.id, id: private_message.id
        response.should redirect_to new_user_session_path
      end
    end

    describe "#new" do
      it "requires the user to be signed in" do
        get :new, user_id: user2.id
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "with signing in" do
    before { sign_in user2 }

    describe "#index" do
      it "populates an array of messages" do
        private_messages = user2.messages.all
        get :index, user_id: private_message.recipient_id
        assigns(:private_messages).should eq([private_message])
      end

      it "renders the index view" do
        get :index, user_id: private_message.recipient_id
        response.should render_template :index
      end
    end

    describe "#show" do
      it "assigns a message" do
        get :show, user_id: user2.id, id: private_message.id
        assigns(:private_message).should eq(private_message)
      end

      it "renders the show view" do
        get :show, user_id: user2.id, id: private_message.id
        response.should render_template :show
      end
    end

    describe "#new" do
      it "renders the new page" do
        get :new, private_message.recipient_id
        response.should render_template :new
      end
    end

    describe "#create" do
      it "creates a new message" do
        expect {
          post :create, user_id: user2.id, private_message: FactoryGirl.attributes_for(:private_message, sender: user2, recipient: user)
        }.to change(PrivateMessage, :count).by(1)
      end

      it "redirects to the index page" do
        post :create, user_id: user2.id, private_message: FactoryGirl.attributes_for(:private_message, sender: user2, recipient: user)
        response.should redirect_to :index
      end

      describe "invalid message" do
        it "should not create a message" do
          expect {
            post :create, user_id: user2.id, private_message: FactoryGirl.attributes_for(:private_message, sender: user2, recipient: user)
          }.to change(PrivateMessage, :count).by(0)
        end

        it "re-renders the new template" do
          post :create, user_id: user2.id, private_message: FactoryGirl.attributes_for(:private_message, sender: user2, recipient: user)
          response.should render_template :new
        end
      end
    end
  end

end
