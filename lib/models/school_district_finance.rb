class SchoolDistrictFinance
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Attributes::Dynamic

  index({ "LEAID" => 1 })
  index({ "_file" => 1 })
  index({ "LEAID" => 1, "_file" => 1 })

  store_in :collection => "school_district_finances"
  
  def self.important_header_key
    "LEAID"
  end

end
SchoolDistrictFinance.create_indexes