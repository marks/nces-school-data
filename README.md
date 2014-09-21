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