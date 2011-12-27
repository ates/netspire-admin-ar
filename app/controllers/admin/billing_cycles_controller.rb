class Admin::BillingCyclesController < AdminController
  respond_to :html

  def index
    @billing_cycles = BillingCycle.paginate(:page => params[:page])
  end

  def new
    @billing_cycle = BillingCycle.new
  end

  def show
    @billing_cycle = BillingCycle.find(params[:id])
  end

  def edit
    @billing_cycle = BillingCycle.find(params[:id])
  end

  def create
    @billing_cycle = BillingCycle.new(params[:billing_cycle])
    @billing_cycle.save!
    flash[:notice] = "BillingCycle was successfully created."
    redirect_to(edit_admin_billing_cycle_url(@billing_cycle))
  end

  def update
    @billing_cycle = BillingCycle.find(params[:id])
    @billing_cycle.attributes = params[:billing_cycle]
    @billing_cycle.save!
    flash[:notice] = "BillingCycle was successfully updated."
    redirect_to(edit_admin_billing_cycle_url(@billing_cycle))
  end

  def destroy
    @billing_cycle = BillingCycle.find(params[:id])
    @billing_cycle.destroy
    redirect_to(admin_billing_cycles_url)
  end

  protected

  def handle_record_invalid
    respond_with(@billing_cycle) do |format|
      format.html do
        action = "new"
        action = "edit" unless @billing_cycle.new_record?
        render :action => action
      end
    end
  end
end
