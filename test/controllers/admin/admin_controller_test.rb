# frozen_string_literal: true

require "test_helper"

# Tests access permissions to admin dashboard controller.
class Admin::AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @viewer = users(:viewer)
    @pending = users(:pending)
  end

  test "should get index as admin" do
    login(@admin)
    get admin_url
    assert_redirected_to setup_url
  end

  test "should not get index as editor" do
    login(@editor)
    get admin_url
    assert_redirected_to dashboard_url
  end

  test "should not get index as viewer" do
    login(@viewer)
    get admin_url
    assert_redirected_to dashboard_url
  end

  test "should not get index as pending user" do
    login(@pending)
    get admin_url
    assert_redirected_to new_user_session_url
  end

  test "should not get index as anonymous user" do
    get admin_url
    assert_redirected_to new_user_session_url
  end
end
