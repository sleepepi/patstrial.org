# frozen_string_literal: true

require "test_helper"

SimpleCov.command_name "test:integration"

# Tests sign in navigation for various users.
class NavigationTest < ActionDispatch::IntegrationTest

  def setup
    @deleted = users(:deleted)
  end

  test "regular users should be able to login" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    sign_in_as(users(:viewer), "123456")
    assert_equal "/dashboard", path
  end

  test "deleted users should be not be allowed to login" do
    get "/dashboard"
    assert_redirected_to new_user_session_path
    sign_in_as(@deleted, "123456")
    assert_equal new_user_session_path, path
    # assert_equal I18n.t("devise.failure.inactive"), flash[:alert]
  end

  test "users who are pending approval should be not be allowed to login" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    sign_in_as(users(:pending), "123456")
    assert_equal new_user_session_path, path
    # assert_equal I18n.t("devise.failure.inactive"), flash[:notice]
  end

  test "root navigation redirected to login page" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    assert_equal I18n.t("devise.failure.unauthenticated"), flash[:alert]
  end

  test "anonymous user should get password reset page" do
    get "/password/new"
    assert_response :success
  end

  test "should get report root and redirect to dashboard" do
    sign_in_as(users(:viewer), "123456")
    get "/reports"
    assert_redirected_to dashboard_path
  end
end
