class BillingCycle < ActiveRecord::Base
  class Type < Enum
    option :FIXED,   0
    option :YEAR,    1
    option :QUARTER, 2
    option :MONTH,   3
    option :WEEK,    4
    option :DAY,     5
  end

  class Unit < Enum
    option :SECOND, 0
    option :MINUTE, 1
    option :HOUR,   2
    option :DAY,    3
  end

  has_many :billing_periods, :dependent => :restrict

  validates :name, :presence => true, :uniqueness => true
  validates :cycle_type, :inclusion => { :in => Type.values }
  validates :unit, :inclusion => { :in => Unit.values }, :if => :fixed_length?
  validates :length, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :canonical_length, :numericality => { :only_integer => true, :greater_than => 0 }

  before_validation :set_canonical_length, :if => :unit_present?

  def cycle_type
    Type.from_value(self[:cycle_type])
  end

  def unit
    Unit.from_value(self[:unit])
  end

  def unit_present?
    unit.present?
  end

  def fixed_length?
    cycle_type == Type::FIXED
  end

  def expiration_from(time)
    next_time = case cycle_type
    when Type::FIXED
      time + canonical_length
    when Type::YEAR
      if smooth?
        time.beginning_of_year + length.years
      else
        time + length.years
      end
    when Type::QUARTER
      if smooth?
        time.beginning_of_quarter + (length * 3).months
      else
        time + (length * 3).months
      end
    when Type::MONTH
      if smooth
        time.beginning_of_month + length.months
      else
        time + length.months
      end
    when Type::WEEK
      if smooth?
        time.beginning_of_week + length.weeks
      else
        time + length.weeks
      end
    when Type::DAY
      if smooth?
        time.beginning_of_day + length.days
      else
        time + length.days
      end
    else
      nil
    end
    next_time ? next_time - 1 : nil
  end

  protected

  def set_canonical_length
    self.canonical_length = case unit
    when Unit::MINUTE
      length.minutes
    when Unit::HOUR
      length.hours
    when Unit::DAY
      length.days
    else
      length
    end
    true
  end
end
