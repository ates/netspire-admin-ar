class AdminPermission < ActiveRecord::Base
  belongs_to :admin
  belongs_to :permission
end
