require 'spec_helper'

describe Blog do
  let(:user) { FactoryGirl.create(:user) }
  before { @blog = user.blogs.build(name: "Test Title", content: "This is a test content") }

  subject { @blog }

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  it { should be_valid }

  describe "when name is not present" do
    before { @blog.name = "" }
    it { should_not be_valid }
  end

  describe "when user has two blogs of the same name" do
    before do
      other_blog = user.blogs.build(name: @blog.name, content: "test")
      other_blog.save
    end
    it { should_not be_valid }
  end
end
