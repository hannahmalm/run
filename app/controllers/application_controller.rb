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


    helpers do 
        def current_user 
            @current_user ||= User.find_by(id: session[:user_id]) 
            #Use ||= because if the current user is already called/found it wont look into the db again
        end 

        def logged_in? #will return boolean t/f, if nil it will return false
            !!current_user
        end 

        def belongs_to_user?(log)
            log.user == current_user 
        end 

        def not_logged_in_helper
            if !current_user
                redirect to "/login"
            end 
        end 
    end 

end 