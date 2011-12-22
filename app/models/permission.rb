class Permission < ActiveRecord::Base
  has_many :admin_permissions
  has_many :admins, :through => :admin_permissions
end
