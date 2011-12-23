class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :timeoutable,
         :token_authenticatable

  attr_accessible :login, :password, :email, :remember_me,
    :admin_permissions_attributes, :active

  has_many :admin_permissions, :dependent => :destroy
  has_many :permissions, :through => :admin_permissions

  accepts_nested_attributes_for :admin_permissions, :allow_destroy => true,
    :reject_if => proc {|attrs| attrs['permission_id'] == '0'}

  validates :login, :presence => true, :uniqueness => true,
    :length => { :in => 3..32 }
  validates :password, :presence => true, :length => { :minimum => 6 },
    :if => :password_required?
  validates :email, :uniqueness => { :allow_blank => true }

  def self.find_for_authentication(conditions={})
    conditions[:active] = true
    super
  end

  def not_assigned_perms
    all_perms = Permission.all
    all_perms.reject! { |p| self.permissions.include?(p) }

    @not_assigned_perms = []
    all_perms.each do |p|
      @not_assigned_perms << self.admin_permissions.build(:permission => p)
    end
    @not_assigned_perms
  end

  private

  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end
