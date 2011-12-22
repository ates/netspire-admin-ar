class AdminController < ApplicationController
  before_filter :authenticate_admin!

  layout 'admin'

  protected

  def current_user
    current_admin
  end
end
