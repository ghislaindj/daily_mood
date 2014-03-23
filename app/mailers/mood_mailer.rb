class MoodMailer < ActionMailer::Base
  default from: "gdjuvigny@gmail.com"

  def daily_email(user)
    @user = user
    @mood = @user.moods.create
    mail(to: user.email, subject: "What's your mood today ?")
  end

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Daily Mood !")
  end
end