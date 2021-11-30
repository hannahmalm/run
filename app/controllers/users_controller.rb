class UsersController < ApplicationController

    get "/login" do #render the login form
        erb :'/users/login' 
    end 

    post "/login" do #post - creating a key value pair to session hash, receive log in form, find the user, log the user in
         #find the user
         user = User.find_by(username: params[:username])
         #authenticate the user - this works with has_secure_password - verify the user is who they say they are by checking hashed password to password given
         if user && user.authenticate(params[:password])
            #log the user in and set the session
            session[:user_id] = user.id
            #redirect to users landing page via dynamic route
            redirect to "users/#{user.id}"
         else 
            flash[:message] = "Please enter a valid Username or Password" #flash error - render in view
            redirect to '/login' #redirect to login
         end 
    end 

    get "/users/:id" do #this is a User Show route 
        not_logged_in_helper
        "User Show Route"
    end 

    get "/signup" do #render the signup form 
        erb :'/users/signup'
    end 


    #1. A user must input a username AND a password. Both fields must be populated
    #2. A user must have a unique username. If they dont, they will get an error that the username 
    post "/signup" do 
        user = User.new(params) #set local variable and inialize a new user by passing in the params
        if user.save 
            session[:user_id] = user.id #set the session equal to the user.id
            redirect "/users/#{user.id}"#once signed up, redirect to the logs page
        else 
            #this is a dynamic active record flash error that is standard for signup
            flash[:errors] = "Signup Failure: #{user.errors.full_messages.to_sentence}" #https://stackoverflow.com/questions/15043272/errors-full-messages-format-in-rails-3
            redirect "/signup" 
        end 
    end 

end 