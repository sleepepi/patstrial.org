require 'test_helper'

# Admins should be able to create and update read-only viewer accounts
class Admin::ViewersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @viewer = viewers(:one)
  end

  test 'should get index as admin' do
    login(@admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:viewers)
  end

  test 'should not get index as editor' do
    login(@editor)
    get :index
    assert_redirected_to dashboard_path
  end

  test 'should get new as admin' do
    login(@admin)
    get :new
    assert_response :success
  end

  test 'should not get new as editor' do
    login(@editor)
    get :new
    assert_redirected_to dashboard_path
  end

  test 'should create viewer as admin' do
    login(@admin)
    assert_difference('Viewer.count') do
      post :create, viewer: { username: 'Viewer3', password: @viewer.password_plain }
    end
    assert_redirected_to viewer_path(assigns(:viewer))
  end

  test 'should not create viewer as editor' do
    login(@editor)
    assert_difference('Viewer.count', 0) do
      post :create, viewer: { username: 'Viewer3', password: @viewer.password_plain }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show viewer as admin' do
    login(@admin)
    get :show, id: @viewer
    assert_response :success
  end

  test 'should not show viewer as editor' do
    login(@editor)
    get :show, id: @viewer
    assert_redirected_to dashboard_path
  end

  test 'should get edit as admin' do
    login(@admin)
    get :edit, id: @viewer
    assert_response :success
  end

  test 'should not get edit as editor' do
    login(@editor)
    get :edit, id: @viewer
    assert_redirected_to dashboard_path
  end

  test 'should update viewer as admin' do
    login(@admin)
    patch :update, id: @viewer, viewer: { username: 'Viewer4', password: 'Password New' }
    assert_redirected_to viewer_path(assigns(:viewer))
  end

  test 'should not update viewer as editor' do
    login(@editor)
    patch :update, id: @viewer, viewer: { username: 'Viewer4', password: 'Password New' }
    assert_redirected_to dashboard_path
  end

  test 'should destroy viewer as admin' do
    login(@admin)
    assert_difference('Viewer.count', -1) do
      delete :destroy, id: @viewer
    end
    assert_redirected_to viewers_path
  end

  test 'should not destroy viewer as editor' do
    login(@editor)
    assert_difference('Viewer.count', 0) do
      delete :destroy, id: @viewer
    end
    assert_redirected_to dashboard_path
  end
end