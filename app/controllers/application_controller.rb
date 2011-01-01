class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    config = BadgerConfig.first
    return true if config.login.blank?

    authenticate_or_request_with_http_basic("Badger") do |login, password|
      config.is_viewer?(login, password)
    end
  end

  def authenticate_admin
    config = BadgerConfig.first
    return session[:admin] = true if config.admin_login.blank?

    authenticate_or_request_with_http_basic("Badger Admin") do |login, password|
      session[:admin] = config.is_admin?(login, password)
    end
  end

  def check_admin
    @is_admin ||= session[:admin]
  end

  helper_method :admin?

  def admin?
    @is_admin
  end
end

