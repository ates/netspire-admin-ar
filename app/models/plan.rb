class Plan < ActiveRecord::Base
  has_many :assigned_services, :dependent => :destroy
  has_many :services, :through => :assigned_services

  accepts_nested_attributes_for :assigned_services, :allow_destroy => true

  validates :name, :presence => true
  validates :code, :presence => true, :format => { :with => /^[A-Za-z\d_-]+$/ }
  validates :active, :inclusion => { :in => [true, false] }
  validates :legacy, :inclusion => { :in => [true, false] }
end
