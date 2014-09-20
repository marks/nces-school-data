class SchoolDistrict
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Attributes::Dynamic

  index({ "SURVYEAR" => 1 })
  index({ "LEAID" => 1 })
  index({ "SURVYEAR" => 1, "LEAID" => 1 })

  store_in :collection => "school_districts"
  
end
SchoolDistrict.create_indexes
