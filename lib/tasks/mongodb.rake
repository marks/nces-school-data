namespace :mongodb do
  task :push_local_to_mongohq do
    require 'open-uri'
    db_name = Mongoid.sessions["default"]["database"]
    mongohq_url = %x(heroku config:get MONGOHQ_URL).gsub("\n","")
    mongohq_uri = URI.parse(mongohq_url)
    mongohq_db = mongohq_uri.path.gsub("/","")

    puts "Removing old mongodump from tmp/#{db_name}/"
    puts "  rm tmp/#{db_name}/*"
    %x(rm tmp/#{db_name}/*)

    puts "Dumping latest local mongodb data to tmp/#{db_name}"
    puts "  mongodump -d #{db_name} -o tmp/"
    %x(mongodump -d #{db_name} -o tmp/)

    puts "mongorestore'ing to MongoHQ"
    puts "  mongorestore -h #{mongohq_uri.host} --port #{mongohq_uri.port} -d #{mongohq_db} -u #{mongohq_uri.user} -p PASSWORD_REMOVED --drop tmp/#{db_name}"
    %x(mongorestore -h #{mongohq_uri.host} --port #{mongohq_uri.port} -d #{mongohq_db} -u #{mongohq_uri.user} -p #{mongohq_uri.password} --drop tmp/#{db_name})
  end
end