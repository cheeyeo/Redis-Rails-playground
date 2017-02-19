class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :track_visits

  def track_visits
    @page_visits = $redis.incr("visits:#{controller_name}:#{action_name}:totals")
  end
end
