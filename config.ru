require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require_relative './models/Placeholder.rb'
require_relative './controllers/placeholder_controller.rb'

# Middleware
use Rack::Reloader
use Rack::MethodOverride

run PlaceHController
