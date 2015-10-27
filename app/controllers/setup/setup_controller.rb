# Provides a unified setup overview for admins and editors
class Setup::SetupController < ApplicationController
  before_action :authenticate_user!
  before_action :check_setup_role

  # GET /setup
  def index
  end

  protected

  def check_setup_role
    redirect_to dashboard_path, alert: 'Only admins or editors may access that page.' unless current_user.setup_role?
  end
end
