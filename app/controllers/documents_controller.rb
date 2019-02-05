# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:download]

  layout "layouts/full_page_sidebar"

  # # GET /docs
  # def index
  #   @documents = Document.all
  # end
end
