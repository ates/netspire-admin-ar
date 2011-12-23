class Domain < ActiveRecord::Base
  has_many :admins
  has_many :accounts

  # for visualization graphs
  def quantity
    self.accounts.count
  end
end
