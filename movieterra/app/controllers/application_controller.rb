class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :auth
  helper_method :current_user

  def auth    
    session[:user_id] = User.create.id if session[:user_id].nil?
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  rescue
    session[:user_id] = User.create.id
    retry
  end
end
