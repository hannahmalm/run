class UsersController < ApplicationController

    get '/login' do #render the login form
        erb :login
    end 

    get '/signup' do #render the signup form 
        erb :signup
    end 

end 