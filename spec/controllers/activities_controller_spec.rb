require 'spec_helper'
describe ActivitiesController do
  include Devise::TestHelpers

  describe "#index" do
    it "populates an array of activities" do
      Activity.stub(all: [activity = stub])
      get :index
      assigns(:activities).should eq([activity])
    end

    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end
end
