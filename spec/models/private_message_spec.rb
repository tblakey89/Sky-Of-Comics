require 'spec_helper'

describe PrivateMessage do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  before { @private_message = user.sent_messages.build(title: "hey", content: "This is a message", recipient_id: user2.id) }

  subject { @private_message }

  it { should respond_to(:read) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:last_reply) }
  it { should respond_to(:recipient) }
  it { should respond_to(:sender) }
  it { should respond_to(:replies) }
  it { should respond_to(:reply) }
  it { should be_valid }

  describe "when content is not present" do
    before { @private_message.content = "" }
    it { should_not be_valid }
  end

  describe "when recipient_id is not present" do
    before { @private_message.recipient_id = "" }
    it { should_not be_valid }
  end

  describe "when a user replies" do
    before { @private_message.save }
    let(:reply) { @private_message.new_reply }

    it { should eq(reply.reply) }

    describe "when a reply is created" do
      before do
        reply.title = "test"
        reply.content = "test"
        reply.save
        @private_message.reload
      end

      it "should change last_reply of message" do
        @private_message.last_reply.should_not be_blank
      end
    end
  end
end
