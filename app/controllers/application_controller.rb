class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordInvalid, :with => :handle_record_invalid
end
