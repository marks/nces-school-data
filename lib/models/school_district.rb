class SchoolDistrict
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  store_in :collection => "school_districts"
  
end