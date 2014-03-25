class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :log_ips

  def after_sign_in_path_for(user)
    moods_path
  end
  def log_ips
    logger.info("request.ip = #{request.ip} and request.remote_ip = #{request.remote_ip}")
  end
end