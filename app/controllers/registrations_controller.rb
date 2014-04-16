class RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if resource.class == User && Time.now - resource.created_at <= 1.minute
        tracker.alias(user.id, mixpanel_id)
        tracker.people.set(user.id, {"$created"     => resource.created_at.to_s,
                                     "$email"       => resource.email
                                    })
      end
    end
  end

  private
    def sign_up_params
      params.require(resource_name).permit(:email, :password, :password_confirmation, moods_attributes: :value)
    end
end