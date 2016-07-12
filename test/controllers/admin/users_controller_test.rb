# frozen_string_literal: true

require 'test_helper'

# Test to assure admins can edit and update users
class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @user = users(:pending)
  end

  def user_params
    {
      first_name: 'First Name',
      last_name: 'Last Name',
      email: 'email@example.com',
      approved: '1',
      admin: '1',
      editor: '1'
    }
  end

  test 'should get index as admin' do
    login(@admin)
    get :index
    assert_not_nil assigns(:users)
    assert_response :success
  end

  test 'should not get index as editor' do
    login(@editor)
    get :index
    assert_nil assigns(:users)
    assert_redirected_to dashboard_path
  end

  test 'should show user as admin' do
    login(@admin)
    get :show, params: { id: @user }
    assert_not_nil assigns(:user)
    assert_response :success
  end

  test 'should not show user as editor' do
    login(@editor)
    get :show, params: { id: @user }
    assert_nil assigns(:user)
    assert_redirected_to dashboard_path
  end

  test 'should get edit as admin' do
    login(@admin)
    get :edit, params: { id: @user }
    assert_not_nil assigns(:user)
    assert_response :success
  end

  test 'should not get edit as editor' do
    login(@editor)
    get :edit, params: { id: @user }
    assert_nil assigns(:user)
    assert_redirected_to dashboard_path
  end

  test 'should update user as admin' do
    login(@admin)
    patch :update, params: { id: @user, user: user_params }
    assert_not_nil assigns(:user)
    assert_equal 'First Name', assigns(:user).first_name
    assert_equal 'Last Name', assigns(:user).last_name
    assert_equal 'email@example.com', assigns(:user).email
    assert_equal true, assigns(:user).approved
    assert_equal true, assigns(:user).admin
    assert_equal true, assigns(:user).editor
    assert_redirected_to admin_user_path(assigns(:user))
  end

  test 'should not update user with blank fields as admin' do
    login(@admin)
    patch :update, params: { id: @user, user: user_params.merge(first_name: '', last_name: '', email: '') }
    assert_not_nil assigns(:user)
    assert assigns(:user).errors.size > 0
    assert_equal ["can't be blank"], assigns(:user).errors[:first_name]
    assert_equal ["can't be blank"], assigns(:user).errors[:last_name]
    assert_equal ["can't be blank"], assigns(:user).errors[:email]
    assert_template :edit
    assert_response :success
  end

  test 'should not update user as editor' do
    login(@editor)
    patch :update, params: { id: @user, user: user_params }
    assert_nil assigns(:user)
    assert_redirected_to dashboard_path
  end

  test 'should destroy user as admin' do
    login(@admin)
    assert_difference('User.current.count', -1) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to admin_users_path
  end

  test 'should not destroy user as editor' do
    login(@editor)
    assert_difference('User.current.count', 0) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to dashboard_path
  end
end
