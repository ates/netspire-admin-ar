class Admin::BillingPeriodsController < AdminController
  respond_to :html

  def index
    @billing_periods = BillingPeriod.paginate(:page => params[:page])
  end

  def new
    @billing_period = BillingPeriod.new
  end

  def show
    @billing_period = BillingPeriod.find(params[:id])
  end

  def edit
    @billing_period = BillingPeriod.find(params[:id])
  end

  def create
    @billing_period = BillingPeriod.new(params[:billing_period])
    @billing_period.save!
    flash[:notice] = "BillingPeriod was successfully created."
    redirect_to(edit_admin_billing_period_url(@billing_period))
  end

  def update
    @billing_period = BillingPeriod.find(params[:id])
    @billing_period.attributes = params[:billing_period]
    @billing_period.save!
    flash[:notice] = "BillingPeriod was successfully updated."
    redirect_to(edit_admin_billing_period_url(@billing_period))
  end

  def destroy
    @billing_period = BillingPeriod.find(params[:id])
    @billing_period.destroy
    redirect_to(admin_billing_periods_url)
  end

  protected

  def handle_record_invalid
    respond_with(@billing_period) do |format|
      format.html do
        action = "new"
        action = "edit" unless @billing_period.new_record?
        render :action => action
      end
    end
  end
end
