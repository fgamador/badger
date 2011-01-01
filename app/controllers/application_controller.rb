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
    return true if config.admin_login.blank?

    authenticate_or_request_with_http_basic("Badger Admin") do |login, password|
      config.is_admin?(login, password)
    end
  end

  def set_admin_mode(val)
    session[:admin_mode] = val
  end

  def check_admin_mode
    @is_admin_mode ||= session[:admin_mode]
  end

  helper_method :admin?

  def admin?
    @is_admin_mode
  end
end

