class ApplicationController < ActionController::Base
  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

  protect_from_forgery

private
  def track_activity(trackable, action = params[ :action], user = current_user)
    user.activities.create! action: action, trackable: trackable
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      @current_permission.permit_params! params
    else
      if current_user
        redirect_to root_url, alert: "You do not have permission to access this page!"
      else
        redirect_to new_user_session_path, alert: "Please sign in"
      end
    end
  end
end
