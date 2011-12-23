class Domain < ActiveRecord::Base
  has_many :admins
  has_many :accounts
end
