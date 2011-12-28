class ServiceLink < ActiveRecord::Base
  belongs_to :account
  belongs_to :assigned_service
  has_many :properties

  validates :account_id, :presence => true
  validates :assigned_service_id, :presence => true,
                                  :uniqueness => { :scope => :account_id }

  before_validation :on_before_validation

  protected

  def on_before_validation
    self.start_at ||= Time.now.utc
    self.scheduled = (start_at > Time.now.utc)
    true
  end
end
