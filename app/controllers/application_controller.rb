class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordInvalid, :with => :handle_record_invalid

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json {
        render :json => {
          :error => exception.message
        }, :status => 404
      }
    end
  end

  WillPaginate.per_page = 15
end
