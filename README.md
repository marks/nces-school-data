nces-data
=========

Quick Start
-----------
1. Tweak variables in `config/app.yml` and `config/mongoid.yml`
2. Run `bundle install`
3. Run `bundle exec rake download_and_insert:schools`
4. Run `bundle exec rake download_and_insert:school_districts`
5. Run `bundle exec rake download_and_insert:school_district_finances`
6. Your specificed MongoDB instance should have three collections full of your data -- one for each take task.
7. To start the web server to access API endpoints listed below, run `foreman start web`

API endpoints
-------------
For each model (currently `School`, `SchoolDistrict`, `SchoolDistrictFinance`) the following endpoints are available (where `MODEL` is the model name and `ID` is a document ID):
- `/stats.json` returns a JSON array of all document IDs
- `/MODEL/ids.json` returns a JSON array of all document IDs
- `/MODEL/first.json` returns a JSON associative array of the first document's data
- `/MODEL/ID.json` returns a JSON associative array of the first document's data
- `/MODEL/all.csv` sends a CSV file to the client with all documents' data

Notes
-----
- Used `(Model.first.as_json.keys - ["_id","c_at","u_at"]).each{|f| puts "field :#{f}, :type => String"}` from `irb` to get list of fields for lib/models/*.rb` files -- this was essential getting `.to_csv` to work
