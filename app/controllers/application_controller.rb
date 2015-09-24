# Main web application controller for PATS Trial website
# Other controllers inherit from this as a base class
# This controller also handles several static pages in views/application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:dashboard]
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
end
