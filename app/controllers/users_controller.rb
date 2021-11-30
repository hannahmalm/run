class UsersController < ApplicationController

    get '/login' do #render the login form
        erb :login
    end 

    post '/login' do #post - creating a key value pair to session hash, receive log in form, find the user, log the user in

    end 

    get '/signup' do #render the signup form 
        erb :signup
    end 

end 