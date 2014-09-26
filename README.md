nces-data
=========

Quick Start
-----------
1. Tweak variables in `config/app.yml` and `config/mongoid.yml`
2. Run `bundle install`
3. Run `bundle exec run rake download_and_insert:schools`
4. Run `bundle exec run rake download_and_insert:school_districts`
5. Run `bundle exec run rake download_and_insert:school_district_finances`
6. Your specificed MongoDB instance should have three collections full of your data -- one for each take task.
7. To start the web server to access JSON endpoints, run `foreman start web`

API endpoints
-------------
For each model (currently `School`, `SchoolDistrict`, `SchoolDistrictFinance`) the following endpoints are available (where `MODEL` is the model name and `ID` is a document ID):
- `/MODEL/ids.json` returns a JSON array of all document IDs
- `/MODEL/first.json` returns a JSON associative array of the first document's data
- `/MODEL/ID.json` returns a JSON associative array of the first document's data