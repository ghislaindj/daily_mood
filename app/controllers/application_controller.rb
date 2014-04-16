class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :log_ips

  include MixpanelTracking

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      backoffice_root_path
    elsif resource.class == User
      moods_path
    else
      root_path
    end
  end
  def log_ips
    logger.info("request.ip = #{request.ip} and request.remote_ip = #{request.remote_ip}")
  end
end