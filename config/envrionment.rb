require 'bundler'
Bundler.require 

configure :development do 
    set :database, {adapter: "sqlite3", database: "db/run.sqlite3"}
end 

#adapter can be sqlite3, MySQL, or Postgres
#database can be called whatever
#ORM Example: DB={conn: SQLite3::Database.new("db./database.db")}
#ActiveRecord Example: ActiveRecord::Base.establish_connection( adapter: "sqlite3", databse: "db/database.sqlite3")



# require_relative '../app/controllers/application_controller.rb'
# require_relative '../app/controllers/logs_controller.rb'
# require_relative '../app/controllers/users_controller.rb'
require_all 'app'