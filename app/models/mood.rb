class Mood
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to     :user

  field          :value,             type: Integer

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
end