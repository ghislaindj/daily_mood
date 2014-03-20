# SERVERS
role :web, "dailymood.radio97.fr"
role :app, "dailymood.radio97.fr"            
role :db, "dailymood.radio97.fr", :primary => true  # This is where Rails migrations will run

# GIT
set :branch,         'master'

set :rvm_ruby_string, 'ruby-2.0.0-p451'
set :rvm_type, :system

require "rvm/capistrano"