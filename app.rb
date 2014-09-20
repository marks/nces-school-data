require 'bundler'
Bundler.require
require 'open-uri'
config_file './config/app.yml'
require "sinatra/reloader" if development?

# require './lib/helpers'
require './lib/models'

use Rack::Deflater

configure :production do
  enable :sessions
  set :session_secret, rand(36**10).to_s(36)
  set :raise_errors, false
  set :show_exceptions, false
end

get '/stats.json' do
	content_type :json
	{:school_districts => SchoolDistrict.count}.to_json
end