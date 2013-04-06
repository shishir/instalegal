class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def signed_in?
    !!current_user
  end

  def current_user
  end

  helper_method :signed_in?, :current_user

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end
end
