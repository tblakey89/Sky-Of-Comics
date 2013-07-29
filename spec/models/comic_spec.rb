require 'spec_helper'

describe Comic do
  let(:user) { FactoryGirl.create(:user) }
  before { @comic = user.comics.build(name: "Test Comic", description: "This is a description for the comic") }

  subject { @comic }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  it { should be_valid }

  describe "when name is not present" do
    before { @comic.name = "" }
    it { should_not be_valid }
  end

  describe "when user has two comics of the same name" do
    before do
      other_comic = user.comics.build(name: @comic.name, description: "test")
      other_comic.save
    end
    it { should_not be_valid }
  end
end
