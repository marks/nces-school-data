class School
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Attributes::Dynamic

  index({ "SURVYEAR" => 1 })
  index({ "NCESSCH" => 1 })
  index({ "_file" => 1 })
  index({ "SURVYEAR" => 1, "NCESSCH" => 1 })
  index({ "SURVYEAR" => 1, "NCESSCH" => 1, "_file" => 1 })

  store_in :collection => "schools"

  def self.important_header_key
    "NCESSCH"
  end

end
School.create_indexes
