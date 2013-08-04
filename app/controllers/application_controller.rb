class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def track_activity(trackable, action = params[ :action], user = current_user)
    user.activities.create! action: action, trackable: trackable
  end
end
