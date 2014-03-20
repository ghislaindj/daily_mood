module SignupHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def setup_user(user)
    # ... code from above omitted
 
    user.moods.build
    user
  end
end