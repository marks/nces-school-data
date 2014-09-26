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
	{
    :schools => School.count,
    :school_districts => SchoolDistrict.count,
    :school_district_finances => SchoolDistrictFinance.count
  }.to_json
end

#####

[School, SchoolDistrict, SchoolDistrictFinance].each do |model|

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

end