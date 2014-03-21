class MoodMailer < ActionMailer::Base
  default from: "gdjuvigny@gmail.com"

  def daily_email(user)
    @user = user
    @mood = @user.moods.create
    mail(to: user.email, subject: "What is your mood today?")
  end
end