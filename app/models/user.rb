class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Group


  has_many                      :moods
  accepts_nested_attributes_for :moods

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,                           type: String, default: ""
  field :encrypted_password,              type: String, default: ""

  ## Recoverable
  field :reset_password_token,            type: String
  field :reset_password_sent_at,          type: Time

  ## Rememberable
  field :remember_created_at,             type: Time

  ## Trackable
  field :sign_in_count,                   type: Integer, default: 0
  field :current_sign_in_at,              type: Time
  field :last_sign_in_at,                 type: Time
  field :current_sign_in_ip,              type: String
  field :last_sign_in_ip,                 type: String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  #field :unconfirmed_email,    :type => String # Only if using reconfirmable


  field :first_name,                      type: String

  ### Devise specific methods ###
  # new function to set the password without knowing the current password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end
  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  ### End of Devise specific methods ###
end