# Initialize MongoDB connection using Mongoid
Mongoid.load!(settings.mongoid_config_file)
Mongoid.raise_not_found_error = false

require_relative 'models/school.rb'
require_relative 'models/school_district.rb'
require_relative 'models/school_district_finance.rb'
