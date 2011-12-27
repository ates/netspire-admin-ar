class AssignedService < ActiveRecord::Base
  class ChargeMode < Enum
    option :START,  0
    option :END,    1
    option :EVENLY, 2
  end

  belongs_to :plan
  belongs_to :service
  belongs_to :billing_cycle
  has_many :service_links, :dependent => :restrict
  has_many :properties, :dependent => :delete_all
  has_many :options, :through => :properties

  accepts_nested_attributes_for :properties

  validates :plan_id, :presence => true
  validates :service_id, :presence => true,
                         :uniqueness => { :scope => :plan_id }

  validates :billing_cycle_id, :presence => true
  validates :charge_mode, :inclusion => { :in => ChargeMode.values }
  validates :periodic_fee, :numericality => true
  validates :setup_fee, :numericality => true

  def charge_mode
    ChargeMode.from_value(self[:charge_mode])
  end

  def title
    "#{plan.name} - #{service.title}"
  end

  def initialize_properties
    service.options.each do |option|
      if option_ids.exclude?(option.id)
        properties.build(:option => option)
      end
    end
  end
end
