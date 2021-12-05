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
        if params[:date] != "" && params[:distance] != "" && params[:pace] != "" 
            @log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], user_id: current_user.id)
            redirect to "/logs/#{@log.id}"
        else 
            #provide flash errors if logs are not completed - date, distance, pace are required
            flash[:valid] = "You must enter a valid date, distance, and pace."
            redirect to '/logs/new'
        end 
    end 

    #show route for log 
    get "/logs/:id" do  #:id is the key in the key, value pair
        not_logged_in_helper
        find_log_by_id
        erb :'/logs/show'
    end 

    # get '/logs/:id/edit' do 
    #     not_logged_in_helper #must be logged in to edit a log
    #     find_log_by_id
    #     @user = User.find_by(id: params[:id])
    #     if belongs_to_user?(@log)
    #         erb :'/logs/edit'
    #     else 
    #         redirect "/users/#{current_user.id}"
    #     end 
    # end 

    get '/logs/:id/edit' do 
        not_logged_in_helper
       # @log = Log.find(params[:id]) #find the log you want to edit 
       find_log_by_id
            if @log && @log.user == current_user
                erb :'/logs/edit'
            else 
                redirect to "/users/#{current_user.id}"
            end  
    end 


    patch "/logs/:id" do 
       not_logged_in_helper #see if the user is logged in
       find_log_by_id #find the log 
       if @log && @log.user == current_user
            @log.update(params[:log]) #click submit to update the log - no need to write update out for all params
            redirect "/logs/#{@log.id}" #redirect to log show page
       else 
            redirect to "/users/#{current_user.id}"
       end 
    end 

    delete '/logs/:id' do 
        not_logged_in_helper
        find_log_by_id
        if @log && @log.user == current_user
            @log.destroy
            redirect "/logs"
        else 
            redirect "/logs"
        end 
    end 



    private 

    def find_log_by_id
        @log = Log.find_by_id(params[:id])
    end 
end 