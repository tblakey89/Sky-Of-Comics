require 'spec_helper'

describe PrivateMessage do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  before { @private_message = user.messages.build(title: "hey", content: "This is a message", recipient_id: user2.id) }

  subject { @private_message }

  it { should respond_to(:read) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:recipient) }
  it { should respond_to(:sender) }
  it { should be_valid }

  describe "when content is not present" do
    before { @private_message.content = "" }
    it { should_not be_valid }
  end

  describe "when recipient_id is not present" do
    before { @private_message.recipient_id = "" }
    it { should_not be_valid }
  end
end
