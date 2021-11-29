require './config/envrionment'

#Mount the controller - Wires it up to the web server (browser) to listen for requests
use Rack::MethodOverride #In order to send patch and delete requests
use LogsController
use UsersController
run ApplicationController