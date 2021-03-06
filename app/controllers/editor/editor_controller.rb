# frozen_string_literal: true

# Root controller for editor pages
class Editor::EditorController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor

  # GET /editor
  def index
    redirect_to setup_path
  end

  protected

  def check_editor
    redirect_to dashboard_path, alert: 'Only editors may access that page.' unless current_user.editor?
  end
end
