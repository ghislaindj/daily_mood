every :day, :at => '21:30am', role: ['app'] do
  rake 'mood:send'
end