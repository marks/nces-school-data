class SchoolDistrict
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Attributes::Dynamic

  index({ "SURVYEAR" => 1 })
  index({ "LEAID" => 1 })
  index({ "_file" => 1 })
  index({ "SURVYEAR" => 1, "LEAID" => 1 })
  index({ "SURVYEAR" => 1, "LEAID" => 1, "_file" => 1 })

  store_in :collection => "school_districts"
  
  def self.important_header_key
    "LEAID"
  end
  
end
SchoolDistrict.create_indexes
