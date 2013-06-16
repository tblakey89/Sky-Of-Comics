require 'spec_helper'

describe Follow do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:follows) { follower.follows.build(followed_id: followed.id) }

  subject { follows }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to followed_id" do
      expect do
        Follow.new(follower_id: follower.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end

  describe "when followed id is not present" do
    before { follows.followed_id = nil }

    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { follows.follower_id = nil }

    it { should_not be_valid }
  end
end
