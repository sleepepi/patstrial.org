# frozen_string_literal: true

# Allows sign in using username or email
class SessionsController < Devise::SessionsController
  prepend_before_action :already_signed_in, only: :new
  prepend_before_action :sign_out_viewer, only: :destroy

  layout "layouts/full_page"

  # Overwrite devise to provide JSON responses as well
  def create
    viewer = Viewer.find_by_username params[:user][:email]
    if viewer && viewer.authenticate(params[:user][:password])
      viewer.sign_in!
      session[:viewer_id] = viewer.id
      redirect_to dashboard_path
    else
      super
    end
  end

  private

  def sign_out_viewer
    session[:viewer_id] = nil
  end

  def already_signed_in
    redirect_to dashboard_path if current_viewer
  end
end
