class Admin::TransactionsController < AdminController
  respond_to :html, :json

  def index
    respond_with(Transaction.all)
  end
end
