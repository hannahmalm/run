class LogsController < ApplicationController

    #render a form for logs
    get '/logs/new' do 
        not_logged_in_helper #check to see if user is logged in
        erb :'/logs/new'
    end 

    post '/logs' do 
        not_logged_in_helper #check to see if user is logged in  - if not logged in redirect
        @log = Log.new(params)
        if @log.save 
            redirect "/logs/#{@log.id}"
        #     #redirect "/logs/index"
        # else 
        # if params[:date] != "" && params[:distance] != "" && params[:pace] != ""
        #     @log = log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :user_id => params[:user_id])
        #     redirect to "/logs/#{@log.id}"
        else 
            #provide flash errors if logs are not completed - date, distance, pace are required
            flash[:errors] = "#{@log.errors.full_messages.to_sentence}"
            redirect to '/logs/new'
        end 
    end 

    #show route for log 
    get "/logs/:id" do  #:id is the key in the key, value pair
       @log = Log.find_by_id(params[:id])
       erb :'/logs/show'
    end 

    get '/logs/:id/edit' do 
        not_logged_in_helper #must be logged in to edit a log
        #determine who made the log - only they can edit it
        if 
            #find the log id that needs to be edited
            @log = Log.find_by_id(params[:id])
             erb :'/logs/edit'
        else 
            
        end 
    end 

    patch "/log/:id" do 
       find_log_by_id

    end 


    private 

    def find_log_by_id
        @log = Log.find_by_id(params[:id])
    end 
end 