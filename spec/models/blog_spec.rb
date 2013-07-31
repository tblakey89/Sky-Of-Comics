require 'spec_helper'

describe Blog do
  let(:user) { FactoryGirl.create(:user) }
  before { @blog = user.blogs.build(title: "Test Title", content: "This is a test content") }

  subject { @blog }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  it { should be_valid }

  describe "when title is not present" do
    before { @blog.title = "" }
    it { should_not be_valid }
  end

  describe "when user has two blogs of the same name" do
    before do
      other_blog = user.blogs.build(title: @blog.title, content: "test")
      other_blog.save
    end
    it { should_not be_valid }
  end
end
