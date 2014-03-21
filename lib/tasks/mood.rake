namespace :mood do
  desc 'Send a daily mail'
  task :send => [:environment] do
    User.all do |user|
      MoodMailer.daily_email(user).deliver
    end
  end
end