class LogsController < ApplicationController

    #render all logs
    get '/logs' do 
        not_logged_in_helper
        @logs = Log.all
        #@log_creator = Log.user.username
        erb :'logs/index'
    end 

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
        find_log_by_id
       erb :'/logs/show'
    end 

    get '/logs/:id/edit' do 
        not_logged_in_helper #must be logged in to edit a log
        #determine who made the log - only they can edit it
        if @log.user == current_user
            find_log_by_id
            erb :'/logs/edit'
        else 
            redirect to "users/#{current_user.id}"
        end 
    end 


    # patch '/logs/:id' do OLD PATCH METHOD
    #         @log = Log.find_by_id(params[:id])
    #         @log.update(distance: params[:distance])
    #         @log.update(pace: params[:pace])
    #         @log.update(avg_heart_rate: params[:avg_heart_rate])
    #         @log.update(notes: params[:notes])
    #         redirect to "/logs/#{@log.id}"        
    # end 

    patch "/log/:id" do 
       find_log_by_id #find the log 
       not_logged_in_helper #see if the user is logged in
       if @log.user == current_user
            @log.update(params) #click submit to update the log - no need to write update out for all params
            redirect "/logs/#{@log.id}" #redirect to low show page
       else 
            redirect to "users/#{current_user.id}"
       end 
    end 


    private 

    def find_log_by_id
        @log = Log.find_by_id(params[:id])
    end 
end 