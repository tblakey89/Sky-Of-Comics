class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
      #Activity.order("created_at desc")
  end
end
