every :day, :at => '07:00am', role: ['app'] do
  rake 'mood:send'
end