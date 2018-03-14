# frozen_string_literal: true

require "test_helper"

# Static external pages should be publicly viewable
class ExternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
  end

  test "should get contact as public viewer" do
    get contact_url
    assert_response :success
  end

  test "should get contact as generic viewer" do
    login_viewer(@generic_viewer)
    get contact_url
    assert_response :success
  end

  test "should get contact as viewer" do
    login(@viewer)
    get contact_url
    assert_response :success
  end

  test "should get landing as public viewer" do
    get landing_url
    assert_response :success
  end

  test "should get landing as generic viewer" do
    login_viewer(@generic_viewer)
    get landing_url
    assert_response :success
  end

  test "should get landing as viewer" do
    login(@viewer)
    get landing_url
    assert_response :success
  end

  test "should get participate as public viewer" do
    get participate_url
    assert_response :success
  end

  test "should get participate as generic viewer" do
    login_viewer(@generic_viewer)
    get participate_url
    assert_response :success
  end

  test "should get participate as viewer" do
    login(@viewer)
    get participate_url
    assert_response :success
  end

  test "should get sites as public viewer" do
    get sites_url
    assert_response :success
  end

  test "should get sites as generic viewer" do
    login_viewer(@generic_viewer)
    get sites_url
    assert_response :success
  end

  test "should get sites as viewer" do
    login(@viewer)
    get sites_url
    assert_response :success
  end
end
