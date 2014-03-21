class Mood
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to     :user

  field          :value,             type: Integer
  field          :token,             type: String

  before_create  :add_token

  validates_presence_of              :user_id

  def url(value = 1)
    "#{Settings.server_url}/moods/update_from_email?token=#{self.token}&value=#{value}"
  end

  def human_value
    case value
    when 1
      "Bad"
    when 2
      "Normal"
    when 3
      "Good"
    else
      "?"
    end
  end

  def add_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Mood.where(token: random_token).exists?
    end
  end
end