# frozen_string_literal: true

# Main web application controller for PATS Trial website
# Other controllers inherit from this as a base class
# This controller also handles several static pages in views/application
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :devise_login?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_location

  def store_location
    if !request.post? && !request.xhr?
      if internal_controllers.include?(params[:controller])
        store_internal_location_in_session
      end
    end
  end

  protected

  def internal_controllers
    %w(
      admin/admin
      admin/users
      admin/viewers
      committees
      internal
      reports
      editor/categories
      editor/committee_members
      editor/committees
      editor/documents
      editor/editor
      editor/members
      editor/sites
      editor/videos
      setup/setup
    )
  end

  def devise_login?
    params[:controller] == 'sessions' && params[:action] == 'create'
  end

  def after_sign_in_path_for(resource)
    session[:internal_url] || dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:first_name, :last_name, :email, :password, :password_confirmation]
    )
  end

  def store_internal_location_in_session
    session[:internal_url] = request.fullpath
  end

  def scrub_order(model, params_order, default_order)
    (params_column, params_direction) = params_order.to_s.strip.downcase.split(' ')
    direction = (params_direction == 'desc' ? 'desc' : nil)
    column_name = model.column_names.collect { |c| model.table_name + '.' + c }.find { |c| c == params_column }
    column_name.blank? ? default_order : [column_name, direction].compact.join(' ')
  end

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { head :ok }
      format.json { head :no_content }
    end
  end

  def current_viewer
    @current_viewer ||= Viewer.find_by_id(session[:viewer_id]) if session[:viewer_id]
  end
  helper_method :current_viewer

  def authenticate_viewer_or_current_user!
    unless current_viewer || current_user
      flash[:alert] = I18n.t('devise.failure.unauthenticated')
      redirect_to new_user_session_path
    end
  end

  def read_json(file_path)
    JSON.parse(File.read(file_path)).with_indifferent_access
  rescue
    nil
  end

  # Expects an "Uploader" type class, ex: uploader = @project.logo
  def send_file_if_present(uploader, *args)
    if uploader.present?
      send_file uploader.path, *args
    else
      head :ok
    end
  end
end
