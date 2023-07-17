class ApplicationController < ActionController::API
  def current_user
    User.first
  end
end
