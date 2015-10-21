# Main web application controller for PATS Trial website
# Other controllers inherit from this as a base class
# This controller also handles several static pages in views/application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :first_name, :last_name, :email,
               :password, :password_confirmation
    end
  end

  def scrub_order(model, params_order, default_order)
    (params_column, params_direction) = params_order.to_s.strip.downcase.split(' ')
    direction = (params_direction == 'desc' ? 'DESC' : nil)
    column_name = (model.column_names.collect { |c| model.table_name + '.' + c }.find { |c| c == params_column })
    column_name.blank? ? default_order : [column_name, direction].compact.join(' ')
  end

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { render nothing: true }
      format.json { head :no_content }
    end
  end
end
