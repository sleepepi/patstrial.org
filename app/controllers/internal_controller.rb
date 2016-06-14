# frozen_string_literal: true

# Allows viewers, editors, and admins to view internal pages and reports, and
# download documents
class InternalController < ApplicationController
  before_action :authenticate_viewer_or_current_user!
  before_action :set_category, only: [:category, :document, :video]
  before_action :set_document, only: [:document]
  before_action :set_video, only: [:video]

  def dashboard
    @recruitment = read_json(Rails.root.join('carrierwave', 'recruitment.json'))
    if @recruitment
      @screened = @recruitment[:screened]
      @consented = @recruitment[:consented]
      @eligible = @recruitment[:eligible]
      @randomized = @recruitment[:randomized]
    end
  end

  def directory
    @order = scrub_order(Member, params[:order], 'members.last_name')
    @members = Member.current.where(archived: false).order(@order).includes(:site)
  end

  def category
    @order = scrub_order(Document, params[:order], 'documents.document')
    @documents = @category.documents.order(@order).page(params[:page]).per(40)
  end

  def document
    if @document.pdf?
      send_file File.join(CarrierWave::Uploader::Base.root, @document.document.url),
                type: 'application/pdf', disposition: 'inline'
    else
      send_file File.join(CarrierWave::Uploader::Base.root, @document.document.url)
    end
  end

  def video
  end

  private

  def set_category
    category_scope = Category.current.where(archived: false)
    unless current_user && current_user.can_view_dsmb_folder?
      category_scope = category_scope.where(dsmb_only: false)
    end
    @category = category_scope.find_by_slug params[:category]
    empty_response_or_root_path(dashboard_path) unless @category
  end

  def set_document
    @document = @category.documents.where(archived: false).find_by_id params[:document_id]
    empty_response_or_root_path(internal_category_path(@category)) unless @document
  end

  def set_video
    @video = @category.videos.where(archived: false).find_by_id params[:video_id]
    empty_response_or_root_path(internal_category_path(@category)) unless @video
  end

  def read_json(file_path)
    JSON.parse(File.read(file_path)).with_indifferent_access
  rescue
    nil
  end
end
