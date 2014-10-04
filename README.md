nces-data
=========

Local Quick Start
-----------------
1. Tweak variables in `config/app.yml` and `config/mongoid.yml`
2. Run `bundle install`
3. Run `bundle exec rake download_and_insert:schools`
4. Run `bundle exec rake download_and_insert:school_districts`
5. Run `bundle exec rake download_and_insert:school_district_finances`
6. Your specificed MongoDB instance should have three collections full of your data -- one for each take task.
7. To start the web server to access API endpoints listed below, run `foreman start web`

Heroku Instructions
-------------------
*Under development*

1. First things first, follow the 'Local Quick Start' steps
2. Add MongoHQ add on: `heroku addons:add mongohq`
3. Run `git commit -am "initial commit" && git push heroku master` to commit and push this code to Heroku
4. Run `bundle exec rake mongodb:push_local_to_mongohq` to upload the data you downloaded locally to the remote heroku database
5. Run `heroku info` and copy and paste the `Web URL` into your web browser of choice.

API endpoints
-------------
For each model (currently `School`, `SchoolDistrict`, `SchoolDistrictFinance`) the following endpoints are available (where `MODEL` is the model name and `ID` is a document ID):
- `/stats.json` returns a JSON array of all document IDs
- `/MODEL/ids.json` returns a JSON array of all document IDs
- `/MODEL/first.json` returns a JSON associative array of the first document's data
- `/MODEL/ID.json` returns a JSON associative array of the first document's data
- `/MODEL/by_primary_key.json?id=PRIMARY_KEY_ID` returns an array of JSON associative arrays of the matches.
 - for example, `/School/by_primary_key.json?id=010000201670` does a School.where(:NCESSCH => "010000201670") query. The primary key is defined by the model's `important_header_key` method.
- `/MODEL/all.csv` sends a CSV file to the client with all documents' data

Notes
-----
- Used `(Model.first.as_json.keys - ["_id","c_at","u_at"]).each{|f| puts "field :#{f}, :type => String"}` from `irb` to get list of fields for lib/models/*.rb` files -- this was essential getting `.to_csv` to work
