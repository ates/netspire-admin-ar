class Admin::DashboardController < AdminController
  def index
    @domains = Domain.all
  end
end
