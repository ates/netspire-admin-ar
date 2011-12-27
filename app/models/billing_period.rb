class BillingPeriod < ActiveRecord::Base
  belongs_to :billing_cycle
  belongs_to :next, :class_name => "BillingPeriod"

  default_scope order("billing_periods.expires_at DESC")
  scope :active, where(:expired => false)
  scope :expired, where(:expired => true)

  validates :billing_cycle_id, :presence => true,
    :uniqueness => { :scope => [:start_at, :expires_at] }
  validates :start_at, :presence => true
  validates :expires_at, :presence => true
  validates :expired, :inclusion => { :in => [true, false] }
  validates :canonical_length,
    :numericality => { :only_integer => true, :greater_than => 0 }

  before_validation :on_before_validation

  def name
    billing_cycle.name
  end

  protected

  def on_before_validation
    self.start_at ||= Time.now.utc
    if billing_cycle.present?
      self.expires_at ||= billing_cycle.expiration_from(start_at)
      self.canonical_length = expires_at.to_i - start_at.to_i
    end
    true
  end
end
