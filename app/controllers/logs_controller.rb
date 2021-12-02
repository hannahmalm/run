class LogsController < ApplicationController

    #render a form for logs
    get '/logs/new' do 
        not_logged_in_helper #check to see if user is logged in
        erb :'/logs/new'
    end 

    post '/logs' do 
        not_logged_in_helper #check to see if user is logged in
        @log = Log.new(params)
        if @log.save 
            redirect "/logs/#{@log.id}"
            #redirect "/logs/index"
        else 
            #provide flash errors if logs are not completed - date, distance, pace are required
            flash[:errors] = "#{@log.errors.full_messages.to_sentence}"
            redirect to '/logs/new'
        end 
    end 

    get '/log/:id' do
        "Test"
    end 

end 