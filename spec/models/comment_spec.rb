require 'spec_helper'

describe Comment do
  let(:comic) { FactoryGirl.create(:comic) }
  before { @comment = comic.comments.build(content: "Hello World") }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:commentable) }
  it { should be_valid }
end
