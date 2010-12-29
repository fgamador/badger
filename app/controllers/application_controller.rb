class ApplicationController < ActionController::Base
  LOGIN = "trustworthy"
  PASSWORD = "loyal"
  ADMIN_LOGIN = "troop20"
  ADMIN_PASSWORD = "Trustworthy2"

  protect_from_forgery

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      session[:admin] = admin = (username == ADMIN_LOGIN && password == ADMIN_PASSWORD)
      admin || (username == LOGIN && password == PASSWORD)
    end
  end

  def check_authentication
    @is_admin ||= session[:admin]
  end

  helper_method :admin?

  def admin?
    @is_admin
  end
end

