module MixpanelTracking

  def self.included(resource)
    resource.helper_method :mixpanel_id
  end

  def tracker
    Mixpanel::Tracker.new(Settings.mixpanel.token)
  end

  def mixpanel_id
    if current_user.present?
      current_user.id
    elsif session[:mixpanel_id].present?
      session[:mixpanel_id]
    else
      session[:mixpanel_id] = SecureRandom.urlsafe_base64
      session[:mixpanel_id]
    end
  end

  def mixpanel_tracking(msg, properties={})
    properties = {} if properties.nil?
    begin
      logger.warn('tracking !!')
      tracker.track(mixpanel_id, msg, properties)
    rescue => e
      logger.error("Seems like a tracking error... #{e}")
    end
  end
end