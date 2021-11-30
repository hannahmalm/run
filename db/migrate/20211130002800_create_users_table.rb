class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
    end 
  end
end


#Migrations are a way to organize and alter database
#Migrations build the database and structure of the database /tables 
#Use activerecord gem to create a mapping between our database and model 
#Migrations are like version control for database
#BCrypt will store a salted, hashed version of our users' passwords in our database in a column called password_digest
#You must have password_digest instead of password as the column name
#Must have BCrypt gem