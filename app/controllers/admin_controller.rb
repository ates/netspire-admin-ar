class AdminController < ApplicationController
  before_filter :authenticate_admin!

  layout 'admin'

  def current_user
    current_admin
  end
end
