class AssignedService < ActiveRecord::Base
  belongs_to :plan
  belongs_to :service
  has_many :service_links, :dependent => :restrict
  has_many :properties, :dependent => :delete_all
  has_many :options, :through => :properties

  accepts_nested_attributes_for :properties

  validates :plan_id, :presence => true
  validates :service_id, :presence => true,
                         :uniqueness => { :scope => :plan_id }
  
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
