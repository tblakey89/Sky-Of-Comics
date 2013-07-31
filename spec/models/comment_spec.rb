require 'spec_helper'

describe Comment do
  let(:comic) { FactoryGirl.create(:comic) }
  let(:user) { FactoryGirl.create(:user) }
  before { @comment = comic.comments.build(content: "Hello World", user_id: user.id) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:commentable) }
  it { should respond_to(:user) }
  it { should be_valid }
end
