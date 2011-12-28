class ServiceLink < ActiveRecord::Base
  belongs_to :account
  belongs_to :assigned_service
  has_many :properties, :dependent => :delete_all
  has_many :options, :through => :properties

  accepts_nested_attributes_for :properties

  validates :account_id, :presence => true
  validates :assigned_service_id, :presence => true,
                                  :uniqueness => { :scope => :account_id }

  before_validation :on_before_validation

  def initialize_properties
    assigned_service.service.options.each do |option|
      if option_ids.exclude?(option.id)
        properties.build(:option => option)
      end
    end
  end

  protected

  def on_before_validation
    self.start_at ||= Time.now.utc
    self.scheduled = (start_at > Time.now.utc)
    true
  end
end
