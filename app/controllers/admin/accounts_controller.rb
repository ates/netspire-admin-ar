class Admin::AccountsController < AdminController
  respond_to :html, :json
  load_and_authorize_resource

  rescue_from Account::BalanceTooLow, :with => :handle_balance_too_low

  def index
    respond_to do |format|
      format.html { @accounts = Account.paginate(:page => params[:page]) }
      format.json { render :json => Account.all }
    end
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(params[:account])
    @account.save!
    flash[:notice] = "Account was created"
    redirect_to(admin_accounts_path)
  end

  def update
    @account = Account.find(params[:id])
    @account.attributes = params[:account]
    @account.save!
    flash[:notice] = "Account was updated"
    redirect_to(edit_admin_account_url(@account))
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Account was deleted"
    redirect_to(admin_accounts_url)
  end

  def deposit
    account = Account.find(params[:id])
    begin
      account.deposit(params[:amount], params[:comment])
      render :json => account.balance
    rescue => e
      render :json => { :error => e.message }, :status => 500
    end
  end

  def withdraw
    account = Account.find(params[:id])
    begin
      account.withdraw(params[:amount], params[:comment])
      render :json => account.balance
    rescue => e
      render :json => { :error => e.message }, :status => 500
    end
  end

  protected

  def handle_balance_too_low
    render :json => { :error => "Balance too low" }, :status => 500
  end

  def handle_record_invalid
    respond_with(@account) do |format|
      format.html do
        action = "new"
        action = "edit" unless @account.new_record?
        render :action => action
      end
    end
  end
end
