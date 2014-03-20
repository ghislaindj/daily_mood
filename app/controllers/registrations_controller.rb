class RegistrationsController < Devise::RegistrationsController

  private
    def sign_up_params
      params.require(resource_name).permit(:email, :password, :password_confirmation, moods_attributes: :value)
    end
end