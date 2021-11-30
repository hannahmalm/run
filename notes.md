Basic App Setup
1. Set up the file structure
    bundle gem run_log in terminal
    create repo in github and push
    mkdir -p app/models
    mkdir app/views
    mkdir app/controllers
    touch app/controllers/application_controller.rb
    mkdir config
    touch config/envrionment.rb
    mkdir db
    mkdir -p public/stylesheets
    touch public/stylesheets/main.css
    touch README.md (already done if run with bundle gem)
    touch CONTRIBUTING.md (already done if run with bundle gem)
    touch LICENSE.md (already done if run with bundle gem)
    touch config.ru
    git add .
    git commit -m 'added file structure'
2. Set up gemfile and bundle install gems
3. Build out requirement file 
4. Build out config.ru file
5. Build out application_controller.rb
6. Add index.erb file in views and run shotgun to test functionality
7. Setup Rakefile - add required fields
    require ‘./config/environment’ #requiring the environment file
    require ‘sinatra/activerecord/rake’ #loads Rake tasks
8. Create DB migration
    - for every table created, create a corresponding model class in models director, and a controller 
    - Could use corneal scaffold NAME to set up folder structure and delete out spec file - Didnt use   corneal for this but it is a possibility
    - Created Users table - Every user should have a unique username and password digest
    - Create Log table - Every log should have a date, userid, etc.
        - have foreign key of user id
    - rake db:create_migration NAME=create_users_table
    - rake db:create_migration NAME=create_logs_table
    - Does not create models file, but creates the data base, structure of db and the tables to include
    - Once rake:db migrate is run then the schema is created
9. Models - The logic of the web app. This is where data is manipulated/saved
    - User has many logs
    - User has secure password - see notes below
    - Logs belong to Users

------------------------------------------------------
Creating Views & Controllers

10. Views - The front end of the user facing part of the application. Has CSS, HTML, and Javascript. This is the only thing the user interacts with directly; Created Controllers & Views simultaniously
    - Layout view = standard view that has the yield, this will also have a nav bar
11. Controllers - Go between for models and views - relays data from the view to the model and then back to the view
     - It is the responsibility of either the session/user to log in or out 
     **AFTER ADDING IN CONTROLLERS/ROUTES, MOUNT THEM INTO config.ru**
     - User controller has signup(get & post), login(get&post), logout(get - does not get its own view), failure route
     - Logs controller has logs(user page), get logs(render new page to create logs), post logs(actually create the new log), show logs()
12. View --> Controller --> Model --> Controller --> View 
13. MVC allows for organization and to keep files seperated using seperation of concerns 

_______________________________________________________

Order of Controller/View creation
1. Users Controller
    - Get and Post login Routes
    - Login erb view file -> Form -> Rendered flash messages
    - Get and Post Signup Routes
    - Signup erb view file -> Form -> Rendered flash messages
    **Used local variables whenever not rendering an erb**
