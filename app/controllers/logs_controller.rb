class LogsController < ApplicationController

    #render a form for logs
    get '/logs/new' do 
        not_logged_in_helper #check to see if user is logged in
        erb :'/logs/new'
    end 

    post '/logs' do 
        not_logged_in_helper #check to see if user is logged in  - if not logged in redirect
        # @log = Log.new(params)
        # if @log.save 
        #     redirect "/logs/#{@log.id}"
        #     #redirect "/logs/index"
        # else 
        if params[:date] != "" && params[:distance] != "" && params[:pace] != ""
            @log = Log.create(date: params[:date], distance: params[:distance], pace: params[:pace], avg_heart_rate: params[:avg_heart_rate], notes: params[:notes], user_id: current_user.id)
            redirect to "/logs/#{@log.id}"
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