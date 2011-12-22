class Admin::AdminsController < AdminController
  respond_to :html

  def index
    @admins = Admin.paginate(:page => params[:page])
  end

  def new
    @admin = Admin.new
  end

  def edit
    params[:id].nil? ? @admin = current_admin : @admin =  Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(params[:admin])
    @admin.save!
    flash[:notice] = "Admin account was created"
    redirect_to(admin_admins_path)
  end

  def update
    @admin = Admin.find(params[:id])
    @admin.attributes = params[:admin]
    @admin.save!
    flash[:notice] = "Admin account was updated"
    redirect_to(edit_admin_admin_url(@admin))
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "Admin account was deleted"
    redirect_to(admin_admins_url)
  end

  protected

  def handle_record_invalid
    respond_with(@admin) do |format|
      format.html do
        action = "new"
        action = "edit" unless @account.new_record?
        render :action => action
      end
    end
  end

end
