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
  
  field :BOUND, :type => String
  field :CBSA, :type => String
  field :CDCODE, :type => String
  field :CONAME, :type => String
  field :CONUM, :type => String
  field :CSA, :type => String
  field :FIPST, :type => String
  field :GSHI, :type => String
  field :GSLO, :type => String
  field :LATCOD, :type => String
  field :LCITY, :type => String
  field :LEAID, :type => String
  field :LONCOD, :type => String
  field :LSTATE, :type => String
  field :LSTREE, :type => String
  field :LZIP, :type => String
  field :LZIP4, :type => String
  field :MCITY, :type => String
  field :METMIC, :type => String
  field :MSTATE, :type => String
  field :MSTREE, :type => String
  field :MZIP, :type => String
  field :MZIP4, :type => String
  field :NAME, :type => String
  field :PHONE, :type => String
  field :STID, :type => String
  field :SURVYEAR, :type => String
  field :TYPE, :type => String
  field :ULOCAL, :type => String
  field :UNION, :type => String
  field :_file, :type => String

  def self.important_header_key
    "LEAID"
  end
  
end
SchoolDistrict.create_indexes
