# frozen_string_literal: true

# Allows viewers, editors, and admins to view internal pages and reports, and
# download documents.
class InternalController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:category, :document, :video, :download_all]
  before_action :set_document, only: [:document]
  before_action :set_video, only: [:video]

  layout "layouts/full_page_sidebar"

  def dashboard
    @recruitment = read_json(Rails.root.join("carrierwave", "recruitment.json"))
    if @recruitment
      @screened = @recruitment[:screened]
      @consented = @recruitment[:consented]
      @eligible = @recruitment[:eligible]
      @randomized = @recruitment[:randomized]
      @grades = @recruitment[:grades]
    end
  end

  def directory
    @order = scrub_order(Member, params[:order], "members.last_name")
    @members = Member.current.where(archived: false).order(@order).includes(:site)
  end

  def category
    @order = scrub_order(Document, params[:order], "documents.document")
    @documents = @category.documents.where(archived: false).order(@order).page(params[:page]).per(40)
    @videos = @category.videos.where(archived: false).page(params[:page]).per(40)
  end

  # POST /:top_level/:category/download-all
  def download_all
    @category.generate_zipped_folder!
    filename = "patstrial-org-#{@category.top_level.parameterize}-#{@category.name.parameterize}.zip"
    send_file_if_present @category.zipped_folder, filename: filename
  end

  def document
    if @document.pdf?
      send_file_if_present @document.document, type: "application/pdf", disposition: "inline"
    else
      send_file_if_present @document.document
    end
  end

  # def video
  # end

  # GET /search
  def search
    @search_documents = find_search_documents
    render layout: "layouts/full_page"
  end

  private

  def set_category
    category_scope = Category.current.where(archived: false)
    category_scope = category_scope.where(unblinded_only: false) unless current_user.can_view_unblinded_folder?
    @category = category_scope.find_by_param(params[:category])
    empty_response_or_root_path(dashboard_path) unless @category
  end

  def set_document
    @document = @category.documents.where(archived: false).find_by(id: params[:document_id])
    empty_response_or_root_path(internal_category_path(@category)) unless @document
  end

  def set_video
    @video = @category.videos.where(archived: false).find_by(id: params[:video_id])
    empty_response_or_root_path(internal_category_path(@category)) unless @video
  end

  def find_search_documents
    params[:search]&.squish!
    if params[:search].present?
      PgSearchDocument
        .search_any_order(params[:search])
        .page(params[:page]).per(10)
    else
      PgSearchDocument.none
    end
  end
end
