class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :timeoutable,
         :token_authenticatable

  attr_accessible :login, :password, :email, :remember_me,
    :admin_permissions_attributes

  has_many :admin_permissions, :dependent => :destroy
  has_many :permissions, :through => :admin_permissions

  accepts_nested_attributes_for :admin_permissions, :allow_destroy => true,
    :reject_if => proc {|attrs| attrs['permission_id'] == '0'}

  def not_assigned_perms
    all_perms = Permission.all
    all_perms.reject! { |p| self.permissions.include?(p) }

    @not_assigned_perms = []
    all_perms.each do |p|
      @not_assigned_perms << self.admin_permissions.build(:permission => p)
    end
    @not_assigned_perms
  end
end
