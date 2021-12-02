class LogsController < ApplicationController

    #render a form for logs
    get '/logs/new' do 
        erb :'/logs/new'
    end 

end 