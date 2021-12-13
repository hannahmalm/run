class LogsController < ApplicationController

   
    get '/logs' do  #render all logs
        not_logged_in_helper #determine if a user is logged in, else redirect to login
        find_log_by_id #find the log id
        @logs = Log.all.order(distance: :desc) #pass the erb an instance variable to iterate over
        erb :'logs/index' #use instance variables to render erb 
    end 

   
    get '/logs/new' do  #render a form for logs
        not_logged_in_helper #determine if a user is logged in, else redirect to login
        erb :'/logs/new'
    end 

    post '/logs' do 
        not_logged_in_helper #determine if a user is logged in, else redirect to login
        if params[:date] != "" && params[:distance] != "" && params[:pace] != "" 
            @log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], user_id: current_user.id)
            redirect to "/logs/#{@log.id}"
        else 
            flash[:valid] = "You must enter a valid date, distance, and pace."
            redirect to '/logs/new'
        end 
    end 

    #show route for log 
    get "/logs/:id" do  #:id is the key in the key, value pair
        not_logged_in_helper #determine if a user is logged in, else redirect to login
        find_log_by_id #find the log id
        erb :'/logs/show'
    end 

    get '/logs/:id/edit' do 
       not_logged_in_helper #determine if a user is logged in, else redirect to login
       find_log_by_id    #find the log id
            if current_log_user_match?
                erb :'/logs/edit'
            else 
                redirect to "/users/#{current_user.id}"
            end  
    end 


    patch "/logs/:id" do 
       not_logged_in_helper #determine if a user is logged in, else redirect to login
       find_log_by_id #find the log id
       if current_log_user_match?
            @log.update(params[:log]) #click submit to update the log - no need to write update out for all params
            redirect "/logs/#{@log.id}" #redirect to log show page
       else 
            redirect to "/users/#{current_user.id}"
       end 
    end 

    delete '/logs/:id' do 
        not_logged_in_helper #determine if a user is logged in, else redirect to login
        find_log_by_id #find the log id
        if current_log_user_match?
            @log.destroy
            redirect "/logs"
        else 
            flash[:delete] = "You can only delete your own logs."
            redirect "/logs"
        end 
    end 

    private 

    def find_log_by_id
        @log = Log.find_by_id(params[:id])
    end 

    def current_log_user_match?
        @log && @log.user == current_user 
    end 
end 