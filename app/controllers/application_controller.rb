class ApplicationController < ActionController::Base
#  LOGIN = "troop20"
#  PASSWORD = "Trustworthy2"

  protect_from_forgery

=begin
  def authenticate
    val = authenticate_or_request_with_http_basic do |username, password|
      username == LOGIN && password == PASSWORD
    end
    # on failure, val holds an error-message string
    session[:admin] = val == true
  end

  def check_authentication
    @is_admin ||= session[:admin]
  end
=end

  helper_method :admin?

  def admin?
    #@is_admin
    true
  end
end

