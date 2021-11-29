require 'bundler'
Bundler.require 

configure :development do 
    set :database, {adapter: "sqlite3", database: "db/run.sqlite3"}
end 



# require_relative '../app/controllers/application_controller.rb'
# require_relative '../app/controllers/logs_controller.rb'
# require_relative '../app/controllers/users_controller.rb'
require_all 'app'