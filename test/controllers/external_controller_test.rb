# frozen_string_literal: true

require "test_helper"

# Static external pages should be publicly viewable.
class ExternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
  end

  test "should get contact as public viewer" do
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

  test "should get landing as viewer" do
    login(@viewer)
    get landing_url
    assert_response :success
  end

  test "should get participate as public viewer" do
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

  test "should get sites as viewer" do
    login(@viewer)
    get sites_url
    assert_response :success
  end

  test "should get credits" do
    get credits_url
    assert_response :success
  end

  test "should get privacy policy" do
    get privacy_policy_url
    assert_response :success
  end

  test "should get version" do
    get version_url
    assert_response :success
  end

  test "should get version as json" do
    get version_url(format: "json")
    version = JSON.parse(response.body)
    assert_equal PatsTrial::VERSION::STRING, version["version"]["string"]
    assert_equal PatsTrial::VERSION::MAJOR, version["version"]["major"]
    assert_equal PatsTrial::VERSION::MINOR, version["version"]["minor"]
    assert_equal PatsTrial::VERSION::TINY, version["version"]["tiny"]
    if PatsTrial::VERSION::BUILD.nil?
      assert_nil version["version"]["build"]
    else
      assert_equal PatsTrial::VERSION::BUILD, version["version"]["build"]
    end
    assert_response :success
  end
end
