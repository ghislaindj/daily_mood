every :day, :at => '08:00am', role: ['app'] do
  rake 'mood:send'
end