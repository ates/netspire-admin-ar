class Admin::AssignedServicesController < AdminController
  respond_to :html

  def edit
    @assigned_service = AssignedService.find(params[:id])
    @assigned_service.initialize_properties
  end

  def update
    @assigned_service = AssignedService.find(params[:id])
    @assigned_service.attributes = params[:assigned_service]
    @assigned_service.save!
    flash[:notice] = "AssignedService was successfully updated."
    redirect_to(edit_admin_assigned_service_url(@assigned_service))
  end

  protected

  def handle_record_invalid
    respond_with(@assigned_service) do |format|
      format.html do
        render :action => "edit"
      end
    end
  end
end
