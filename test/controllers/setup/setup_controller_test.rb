# frozen_string_literal: true

require 'test_helper'

# Tests access to unified setup overview for different roles
class Setup::SetupControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
  end

  test 'should get index as admin' do
    login(@admin)
    get :index
    assert_response :success
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_response :success
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index
    assert_redirected_to dashboard_path
  end

  test 'should not get index as generic viewer' do
    login_viewer(@generic_viewer)
    get :index
    assert_redirected_to new_user_session_path
  end

  test 'should not get index as public viewer' do
    get :index
    assert_redirected_to new_user_session_path
  end
end
