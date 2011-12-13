class Account < ActiveRecord::Base
  class BalanceTooLow < StandardError; end

  attr_accessible :login, :password

  has_many :service_links, :dependent => :destroy
  has_many :assigned_services, :through => :service_links
  has_many :transactions, :dependent => :delete_all

  scope :recent, order("accounts.created_at DESC")
  scope :active, where(:active => true)

  validates :login, :presence => true, :uniqueness => true,
                    :length => { :in => 3..32 }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :active, :inclusion => { :in => [true, false] }

  def lock
    transaction do
      lock!
      self.active = false
      save!
    end
  end

  def unlock
    transaction do
      lock!
      self.active = true
      save!
    end
  end

  def deposit(amount)
    assert_valid_amount(amount)

    transaction do
      lock!
      transactions.create!(:amount => amount,
                           :code => Transaction::Type::DEPOSIT)
      self.balance += amount
      save!
    end
  end

  def withdraw(amount)
    assert_valid_amount(amount)

    transaction do
      lock!
      transactions.create!(:amount => (- amount),
                          :code => Transaction::Type::WITHDRAW)
      raise BalanceTooLow if balance < amount
      self.balance -= amount
      save!
    end
  end

  private

  def assert_valid_amount(amount)
    raise ArgumentError, "Argument is not numeric" unless amount.is_a?(Numeric)
    raise ArgumentError, "Argument must be greater than zero" unless amount > 0
  end
end
