class Property < ActiveRecord::Base
  belongs_to :option
  belongs_to :assigned_service
  belongs_to :service_link

  validates :option_id, :presence => true
  validates :value, :presence => true
end
