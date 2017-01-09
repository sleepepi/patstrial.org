# frozen_string_literal: true

require 'test_helper'

# Editors should be able to upload documents to categories
class Editor::DocumentsControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @category = categories(:one)
    @document = documents(:one)
  end

  def document_params
    {
      document: fixture_file_upload('../../test/support/documents/test_01.doc'),
      archived: @document.archived
    }
  end

  test 'should get index as editor' do
    login(@editor)
    get :index, params: { category_id: @category }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:documents)
    assert_response :success
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index, params: { category_id: @category }
    assert_nil assigns(:category)
    assert_nil assigns(:documents)
    assert_redirected_to dashboard_path
  end

  test 'should get new as editor' do
    login(@editor)
    get :new, params: { category_id: @category }
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer)
    get :new, params: { category_id: @category }
    assert_redirected_to dashboard_path
  end

  test 'should create document as editor' do
    login(@editor)
    assert_difference('Document.count') do
      post :create, params: { category_id: @category, document: document_params }
    end
    assert_redirected_to editor_category_document_path(assigns(:category), assigns(:document))
  end

  test 'should not create document without file' do
    login(@editor)
    assert_difference('Document.count', 0) do
      post :create, params: { category_id: @category, document: document_params.merge(document: '') }
    end

    assert_not_nil assigns(:document)
    assert assigns(:document).errors.size > 0
    assert_equal ["can't be blank"], assigns(:document).errors[:document]
    assert_template 'new'
  end

  test 'should not create document as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      post :create, params: { category_id: @category, document: document_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should upload multiple documents as editor' do
    login(@editor)
    assert_difference('Document.count', 2) do
      post :create_multiple, params: {
        category_id: @category,
        documents: [fixture_file_upload('../../test/support/documents/test_01.docx'),
                    fixture_file_upload('../../test/support/documents/test_01.pdf')]
      }, format: 'js'
    end
    assert_template 'index'
    assert_response :success
  end

  test 'should not upload multiple documents as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      post :create_multiple, params: {
        category_id: @category,
        documents: [fixture_file_upload('../../test/support/documents/test_01.docx'),
                    fixture_file_upload('../../test/support/documents/test_01.pdf')]
      }, format: 'js'
    end
    assert_redirected_to dashboard_path
  end

  test 'should show document as editor' do
    login(@editor)
    get :show, params: { category_id: @category, id: @document }
    assert_response :success
  end

  test 'should not show document as viewer' do
    login(@viewer)
    get :show, params: { category_id: @category, id: @document }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { category_id: @category, id: @document }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { category_id: @category, id: @document }
    assert_redirected_to dashboard_path
  end

  test 'should update document as editor' do
    login(@editor)
    patch :update, params: { category_id: @category, id: @document, document: document_params }
    assert_redirected_to editor_category_document_path(assigns(:category), assigns(:document))
  end

  test 'should not update document with invalid file' do
    login(@editor)
    patch :update, params: { category_id: @category, id: @document, document: document_params.merge(document: fixture_file_upload('../../test/support/documents/test_01.txt')) }
    assert_not_nil assigns(:document)
    assert assigns(:document).errors.size > 0
    assert_equal ["is not allowed to include \"txt\" files, allowed types: #{DocumentUploader.new.extension_whitelist.join(', ')}"], assigns(:document).errors[:document]
    assert_template 'edit'
    assert_response :success
  end

  test 'should not update document as viewer' do
    login(@viewer)
    patch :update, params: { category_id: @category, id: @document, document: document_params }
    assert_redirected_to dashboard_path
  end

  test 'should destroy document as editor' do
    login(@editor)
    assert_difference('Document.count', -1) do
      delete :destroy, params: { category_id: @category, id: documents(:noattachment) }
    end
    assert_redirected_to editor_category_documents_path(assigns(:category))
  end

  test 'should not destroy document as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      delete :destroy, params: { category_id: @category, id: documents(:noattachment) }
    end
    assert_redirected_to dashboard_path
  end
end
