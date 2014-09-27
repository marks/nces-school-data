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

MODELS = [School, SchoolDistrict, SchoolDistrictFinance]

get '/' do
  redirect '/stats.json'
end

get '/stats.json' do
	content_type :json
  hash = {}
  MODELS.each{|m| hash[m.to_s] = {:count => m.count}}
  hash.to_json
end

#####

MODELS.each do |model|

  get "/#{model}/ids.json" do
    content_type :json
    model.all.pluck(:_id).map(&:to_s).to_json
  end

  get "/#{model}/first.json" do
    content_type :json
    model.first.to_json
  end

  get "/#{model}/:id.json" do
    content_type :json
    model.find(params[:id]).to_json
  end

  get "/#{model}/all.csv" do
    content_type 'application/csv'
    attachment "#{model}-all-#{Time.now.to_s.gsub(' ','_')}).csv"
    model.to_csv
  end

end