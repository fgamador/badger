class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    config = BadgerConfig.first
    return true if config.login.blank?

    authenticate_or_request_with_http_basic("Badger") do |login, password|
      config.viewer?(login, password)
    end
  end

  def authenticate_admin
    config = BadgerConfig.first
    return true if config.admin_login.blank?

    authenticate_or_request_with_http_basic("Badger Admin") do |login, password|
      config.admin?(login, password)
    end
  end

  def set_admin_mode(val)
    session[:admin_mode] = val
  end

  def set_show_inactive(val)
    session[:show_inactive] = val
  end

  def cache_session_vars
    @admin_mode ||= session[:admin_mode]
    @show_inactive ||= session[:show_inactive]
  end

  helper_method :admin?, :show_inactive?

  def admin?
    @admin_mode
  end

  def show_inactive?
    @show_inactive
  end
end

