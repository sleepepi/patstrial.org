# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:download]

  layout "layouts/full_page_sidebar"

  # GET /docs
  def index
    if current_user.can_view_unblinded_folder?
      @documents = Document.latest_files
    else
      @documents = Document.latest_files_blinded
    end
  end
end
