# Allows viewers, editors, and admins to view internal pages and reports, and
# download documents
class InternalController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:category, :document]
  before_action :set_document, only: [:document]

  def dashboard
  end

  def directory
    @order = scrub_order(Member, params[:order], 'members.last_name')
    @members = Member.current.order(@order).page(params[:page]).per(40)
  end

  def category
  end

  def document
    if @document.pdf?
      send_file File.join(CarrierWave::Uploader::Base.root, @document.document.url), type: 'application/pdf', disposition: 'inline'
    else
      send_file File.join(CarrierWave::Uploader::Base.root, @document.document.url)
    end
  end

  private

  def set_category
    @category = Category.current.where(archived: false).find_by_slug params[:category]
    empty_response_or_root_path(dashboard_path) unless @category
  end

  def set_document
    @document = @category.documents.where(archived: false).find_by_id params[:document_id]
    empty_response_or_root_path(internal_category_path(@category)) unless @document
  end
end
