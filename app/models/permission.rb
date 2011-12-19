class Permission < ActiveRecord::Base
  has_many :admin_permissions
  has_many :admin, :through => :admin_permissions
end
