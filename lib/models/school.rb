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

  field :CDCODE, :type => String
  field :CHARTR, :type => String
  field :CONAME, :type => String
  field :CONUM, :type => String
  field :FIPST, :type => String
  field :GSHI, :type => String
  field :GSLO, :type => String
  field :LATCOD, :type => String
  field :LCITY, :type => String
  field :LEAID, :type => String
  field :LEANM, :type => String
  field :LONCOD, :type => String
  field :LSTATE, :type => String
  field :LSTREE, :type => String
  field :LZIP, :type => String
  field :LZIP4, :type => String
  field :MCITY, :type => String
  field :MSTATE, :type => String
  field :MSTREE, :type => String
  field :MZIP, :type => String
  field :MZIP4, :type => String
  field :NCESSCH, :type => String
  field :PHONE, :type => String
  field :SCHNAM, :type => String
  field :SCHNO, :type => String
  field :SEASCH, :type => String
  field :STATUS, :type => String
  field :STID, :type => String
  field :SURVYEAR, :type => String
  field :TYPE, :type => String
  field :ULOCAL, :type => String
  field :_file, :type => String

  def self.important_header_key
    "NCESSCH"
  end

end
School.create_indexes
