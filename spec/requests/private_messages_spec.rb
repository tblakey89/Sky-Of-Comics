require 'spec_helper'

describe "PrivateMessagePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:private_message) { FactoryGirl.create(:private_message, sender: user, recipient_id: user.id) }

  before { valid_signin user }

  describe "message creation" do
    before { visit new_user_private_message_path(user_id: user.id) }

    it { should have_selector("title", text: "New Message") }

    describe "with valid information" do
      before do
        fill_in 'Title', with: "test message"
        fill_in 'Content', with: "test message"
      end

      it "should create a comic" do
        expect { click_button "Send" }.should change(PrivateMessage, :count).by(1)
      end
    end
  end

  describe "visit a message page" do
    before { visit user_private_message_path(user_id: user.id, id: private_message.id) }

    it { should have_selector('title', text: private_message.title) }
  end

  describe "visit the message index" do
    before { visit user_private_messages_path(user_id: private_message.recipient.id) }

    it { should have_selector('title', text: "Messages") }
    it { should have_content(private_message.title) }
  end

  describe "visit the sent messages page" do
    before { visit sent_user_private_messages_path(user_id: private_message.recipient.id) }

    it { should have_selector('title', text: "Sent Messages") }
    it { should have_selector('li', text: private_message.title) }
  end
end
