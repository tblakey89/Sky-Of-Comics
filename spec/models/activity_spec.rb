require 'spec_helper'

describe Activity do
  let(:user) { FactoryGirl.create(:user) }
  let(:comic) { FactoryGirl.create(:comic) }
  before { @activity = user.activities.build(action: "create", trackable: comic) }

  subject { @activity }

  it { should respond_to(:action) }
  it { should respond_to(:trackable) }
  it { should respond_to(:user) }
end
