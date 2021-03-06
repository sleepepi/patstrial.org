# frozen_string_literal: true

require "test_helper"

# Tests access to unified setup overview for different roles.
class Setup::SetupControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  test "should get index as admin" do
    login(@admin)
    get setup_url
    assert_response :success
  end

  test "should get index as editor" do
    login(@editor)
    get setup_url
    assert_response :success
  end

  test "should not get index as viewer" do
    login(@viewer)
    get setup_url
    assert_redirected_to dashboard_url
  end

  test "should not get index as public viewer" do
    get setup_url
    assert_redirected_to new_user_session_url
  end
end
