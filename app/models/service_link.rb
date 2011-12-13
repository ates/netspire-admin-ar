class ServiceLink < ActiveRecord::Base
  belongs_to :account
  belongs_to :assigned_service

  validates :account_id, :presence => true
  validates :assigned_service_id, :presence => true,
                                  :uniqueness => { :scope => :account_id }
end
