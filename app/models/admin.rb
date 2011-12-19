class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :timeoutable,
         :token_authenticatable

  attr_accessible :login, :password, :email, :remember_me

  has_many :admin_permissions
  has_many :permissions, :through => :admin_permissions
end
