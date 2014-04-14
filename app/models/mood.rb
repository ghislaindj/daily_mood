require 'barometer'

class Mood
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Group

  belongs_to     :user
  embeds_one     :weather,  class_name: 'Mood::Weather'


  field          :value,             type: Integer
  field          :token,             type: String
  field          :ip,                type: String

  before_create  :add_token

  validates_presence_of              :user_id

  def url(value = 1)
    "#{Settings.server_url}/moods/update_from_email?token=#{self.token}&value=#{value}"
  end

  def icon(svg = true)
    svg ? Settings.moods.find{|m| m.value == self.value}.try(:icon) : Settings.moods.find{|m| m.value == self.value}.try(:png_icon)
  end

  def human_name
    Settings.moods.find{|m| m.value == self.value}.try(:human_name)
  end

  def add_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Mood.where(token: random_token).exists?
    end
  end

  def add_weather
    if self.weather.nil? && self.ip.present?
      barometer = Barometer.new(self.ip)
      w = barometer.measure.today
      self.weather = Mood::Weather.new condition: w.condition, high: w.high, icon: w.icon, low: w.low, pop: w.pop
    end
  end

  class Weather
    include Mongoid::Document
    embedded_in    :mood,     inverse_of: :weather

    field          :condition,       type: String
    field          :high,            type: String
    field          :icon,            type: String
    field          :low,             type: String
    field          :pop,             type: String

    def icon_url
      "http://icons.wxug.com/i/c/j/#{self.icon}.gif"
    end
  end
end