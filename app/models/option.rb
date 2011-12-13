class Option < ActiveRecord::Base
  class Type < Enum
    option :STRING,   0
    option :BOOLEAN,  1
    option :NUMERIC,  2
  end

  belongs_to :service
  has_many :properties, :dependent => :delete_all

  validates :service_id, :presence => true
  validates :name, :presence => true
  validates :title, :presence => true
  validates :required, :inclusion => { :in => [true, false] }
  validates :overridable, :inclusion => { :in => [true, false] }
  validates :value_type, :inclusion => { :in => Type.values }

  def value_type
    Type.from_value(self[:value_type])
  end
end
