# frozen_string_literal: true

# Allows editors to upload documents to categories
class Editor::DocumentsController < Editor::EditorController
  before_action :set_category
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /:category_id/documents
  def index
    @order = scrub_order(Document, params[:order], 'documents.archived, documents.document')
    @documents = @category.documents.order(@order).page(params[:page]).per(40)
  end

  # GET /:category_id/documents/1
  def show
  end

  # GET /:category_id/documents/new
  def new
    @document = @category.documents.new
  end

  # GET /:category_id/documents/1/edit
  def edit
  end

  # POST /:category_id/documents
  def create
    @document = @category.documents.new(document_params)
    if @document.save
      redirect_to editor_category_document_path(@category, @document), notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  # POST /:category_id/documents/upload.js
  def create_multiple
    @documents_count = @category.documents.count
    params[:documents].each do |document|
      @category.documents.create(document: document)
    end
    render :index
  end

  # PATCH /:category_id/documents/1
  def update
    if @document.update(document_params)
      redirect_to editor_category_document_path(@category, @document), notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /:category_id/documents/1
  def destroy
    @document.destroy
    redirect_to editor_category_documents_path(@category), notice: 'Document was successfully deleted.'
  end

  private

  def set_category
    @category = Category.current.find_by_param(params[:category_id])
    empty_response_or_root_path(editor_categories_path) unless @category
  end

  def set_document
    @document = @category.documents.find_by(id: params[:id])
    empty_response_or_root_path(editor_category_path(@category)) unless @document
  end

  def document_params
    params.require(:document).permit(:document, :archived)
  end
end
