# Root controller for admin pages
class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  # GET /admin
  def index
  end

  protected

  def check_admin
    redirect_to dashboard_path, alert: 'Only admins may access that page.' unless current_user.admin?
  end
end
