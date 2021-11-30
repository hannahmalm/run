class UsersController < ApplicationController

    get '/login' do #render the login form
        erb :login
    end 

    post '/login' do #post - creating a key value pair to session hash, receive log in form, find the user, log the user in
         #find the user
         @user = User.find_by(username: params[:username])
         #authenticate the user - this works with has_secure_password - verify the user is who they say they are
         if @user && @user.authenticate(password: params[:password])
            #log the user in
            session[:user_id] = @user.id
            #redirect to users landing page via dynamic route
            redirect to "/users/#{@user.id}"
         else 
            flash[:message] = "Please enter a valid Username or Password" #flash error - render in view
            redirect to '/login' #redirect to login
         end 
    end 

    get '/signup' do #render the signup form 
        erb :signup
    end 

end 