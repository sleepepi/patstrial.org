# frozen_string_literal: true

require 'test_helper'

# Admins should be able to create and update read-only viewer accounts
class Admin::ViewersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @viewer = viewers(:one)
  end

  def viewer_params
    {
      username: 'Viewer3',
      password: @viewer.password_plain,
      description: @viewer.description
    }
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
      post :create, params: { viewer: viewer_params }
    end
    assert_redirected_to admin_viewer_path(assigns(:viewer))
  end

  test 'should not create viewer with blank username' do
    login(@admin)
    assert_difference('Viewer.count', 0) do
      post :create, params: { viewer: viewer_params.merge(username: '') }
    end
    assert_not_nil assigns(:viewer)
    assert assigns(:viewer).errors.size > 0
    assert_equal ["can't be blank", 'is invalid'], assigns(:viewer).errors[:username]
    assert_template 'new'
  end

  test 'should not create viewer as editor' do
    login(@editor)
    assert_difference('Viewer.count', 0) do
      post :create, params: { viewer: viewer_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show viewer as admin' do
    login(@admin)
    get :show, params: { id: @viewer }
    assert_response :success
  end

  test 'should not show viewer as editor' do
    login(@editor)
    get :show, params: { id: @viewer }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as admin' do
    login(@admin)
    get :edit, params: { id: @viewer }
    assert_response :success
  end

  test 'should not get edit as editor' do
    login(@editor)
    get :edit, params: { id: @viewer }
    assert_redirected_to dashboard_path
  end

  test 'should update viewer as admin' do
    login(@admin)
    patch :update, params: {
      id: @viewer,
      viewer: viewer_params.merge(username: 'Viewer4', password: 'Password New')
    }
    assert_redirected_to admin_viewer_path(assigns(:viewer))
  end

  test 'should update viewer with blank username' do
    login(@admin)
    patch :update, params: {
      id: @viewer,
      viewer: { username: '', password: 'Password New', description: @viewer.description }
    }
    assert_not_nil assigns(:viewer)
    assert assigns(:viewer).errors.size > 0
    assert_equal ["can't be blank", 'is invalid'], assigns(:viewer).errors[:username]
    assert_template 'edit'
  end

  test 'should not update viewer as editor' do
    login(@editor)
    patch :update, params: {
      id: @viewer,
      viewer: viewer_params.merge(username: 'Viewer4', password: 'Password New')
    }
    assert_redirected_to dashboard_path
  end

  test 'should destroy viewer as admin' do
    login(@admin)
    assert_difference('Viewer.count', -1) do
      delete :destroy, params: { id: @viewer }
    end
    assert_redirected_to admin_viewers_path
  end

  test 'should not destroy viewer as editor' do
    login(@editor)
    assert_difference('Viewer.count', 0) do
      delete :destroy, params: { id: @viewer }
    end
    assert_redirected_to dashboard_path
  end
end
