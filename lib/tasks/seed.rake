namespace :seed do
  desc 'Seed moods'
  task :moods => [:environment] do
    start = 1.week.ago.to_datetime
    finish = 1.day.ago.to_datetime
    user = User.create email: "ghislain@milky.fr"
    user.send_confirmation_instructions

    while(start < finish) do
      start += 1.day
      User.all.each do |user|
        mood = Mood.timeless.create user: user, value: Settings.moods.sample.value, created_at: start, updated_at: start
      end
    end
  end
end