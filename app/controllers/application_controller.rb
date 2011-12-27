class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordInvalid, :with => :handle_record_invalid

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  WillPaginate.per_page = 15
end
