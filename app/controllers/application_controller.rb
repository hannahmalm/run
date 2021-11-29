require "./config/envrionment"

class ApplicationController < Sinatra::Base 
    configure do  #configure block tells controller where to look for views and enable sessions
        set :public_folder, 'public'
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security" #extra layer of security
        register Sinatra::Flash #sinatra takes this info and turns it into a hash
    end 

    get "/" do 
        erb :index
    end 


end 