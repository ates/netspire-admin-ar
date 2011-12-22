class Admin::TransactionsController < AdminController
  respond_to :html
  load_and_authorize_resource

  def index
    @transanctions = scope.paginate(:page => params[:page])
  end

  protected

  def parent
    if id = params[:a]
      Account.find(id)
    else
      Transaction.all
    end
  end

  def scope
    if id = params[:a]
      Account.find(id).transactions
    else
      Transaction
    end
  end

  def handle_record_invalid
    respond_with(@transaction) do |format|
      format.html do
        action = "new"
        render :action => action
      end
    end
  end
end
