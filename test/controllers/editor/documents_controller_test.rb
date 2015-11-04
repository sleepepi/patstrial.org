require 'test_helper'

# Editors should be able to upload documents to categories
class Editor::DocumentsControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @category = categories(:one)
    @document = documents(:one)
  end

  test 'should get index as editor' do
    login(@editor)
    get :index, category_id: @category
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:documents)
    assert_response :success
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index, category_id: @category
    assert_nil assigns(:category)
    assert_nil assigns(:documents)
    assert_redirected_to dashboard_path
  end

  test 'should get new as editor' do
    login(@editor)
    get :new, category_id: @category
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer)
    get :new, category_id: @category
    assert_redirected_to dashboard_path
  end

  test 'should create document as editor' do
    login(@editor)
    assert_difference('Document.count') do
      post :create, category_id: @category, document: { document: fixture_file_upload('../../test/support/documents/test_01.doc'), archived: @document.archived }
    end
    assert_redirected_to editor_category_document_path(assigns(:category), assigns(:document))
  end

  test 'should not create document without file' do
    login(@editor)
    assert_difference('Document.count', 0) do
      post :create, category_id: @category, document: { document: '', archived: @document.archived }
    end

    assert_not_nil assigns(:document)
    assert assigns(:document).errors.size > 0
    assert_equal ["can't be blank"], assigns(:document).errors[:document]
    assert_template 'new'
  end

  test 'should not create document as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      post :create, category_id: @category, document: { document: fixture_file_upload('../../test/support/documents/test_01.doc'), archived: @document.archived }
    end
    assert_redirected_to dashboard_path
  end

  test 'should upload multiple documents as editor' do
    login(@editor)
    assert_difference('Document.count', 2) do
      post :create_multiple, category_id: @category,
                             documents: [fixture_file_upload('../../test/support/documents/test_01.docx'),
                                         fixture_file_upload('../../test/support/documents/test_01.pdf')],
                             format: 'js'
    end
    assert_template 'index'
    assert_response :success
  end

  test 'should not upload multiple documents as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      post :create_multiple, category_id: @category,
                             documents: [fixture_file_upload('../../test/support/documents/test_01.docx'),
                                         fixture_file_upload('../../test/support/documents/test_01.pdf')],
                             format: 'js'
    end
    assert_redirected_to dashboard_path
  end

  test 'should show document as editor' do
    login(@editor)
    get :show, category_id: @category, id: @document
    assert_response :success
  end

  test 'should not show document as viewer' do
    login(@viewer)
    get :show, category_id: @category, id: @document
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, category_id: @category, id: @document
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, category_id: @category, id: @document
    assert_redirected_to dashboard_path
  end

  test 'should update document as editor' do
    login(@editor)
    patch :update, category_id: @category, id: @document, document: { document: fixture_file_upload('../../test/support/documents/test_01.doc'), archived: @document.archived }
    assert_redirected_to editor_category_document_path(assigns(:category), assigns(:document))
  end

  test 'should not update document with invalid file' do
    login(@editor)
    patch :update, category_id: @category, id: @document, document: { document: fixture_file_upload('../../test/support/documents/test_01.txt'), archived: @document.archived }
    assert_not_nil assigns(:document)
    assert assigns(:document).errors.size > 0
    assert assigns(:document).errors[:document].include? "You are not allowed to upload \"txt\" files, allowed types: #{DocumentUploader.new.extension_white_list.join(', ')}"
    assert_template 'edit'
  end

  test 'should not update document as viewer' do
    login(@viewer)
    patch :update, category_id: @category, id: @document, document: { document: fixture_file_upload('../../test/support/documents/test_01.doc'), archived: @document.archived }
    assert_redirected_to dashboard_path
  end

  test 'should destroy document as editor' do
    login(@editor)
    assert_difference('Document.count', -1) do
      delete :destroy, category_id: @category, id: @document
    end
    assert_redirected_to editor_category_documents_path(assigns(:category))
  end

  test 'should not destroy document as viewer' do
    login(@viewer)
    assert_difference('Document.count', 0) do
      delete :destroy, category_id: @category, id: @document
    end
    assert_redirected_to dashboard_path
  end
end
