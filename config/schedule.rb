every :day, :at => '9:40pm', role: ['app'] do
  rake 'mood:send'
end