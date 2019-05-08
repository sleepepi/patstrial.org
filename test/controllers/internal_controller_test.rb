# frozen_string_literal: true

require "test_helper"

# Viewers, editors, and admins should be able to see static internal pages.
class InternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
    @unblinded = users(:unblinded)
    @editor = users(:editor)
  end

  test "should get dashboard as viewer" do
    login(@viewer)
    get dashboard_url
    assert_response :success
  end

  test "should not get dashboard as anonymous user" do
    get dashboard_url
    assert_redirected_to new_user_session_url
  end

  test "should get directory as viewer" do
    login(@viewer)
    get directory_url
    assert_response :success
  end

  test "should not get directory as anonymous user" do
    get directory_url
    assert_redirected_to new_user_session_url
  end

  test "should get category as viewer" do
    login(@viewer)
    get internal_category_url(categories(:one).top_level, categories(:one).slug)
    assert_response :success
  end

  test "should not get category as anonymous user" do
    get internal_category_url(categories(:one).top_level, categories(:one).slug)
    assert_redirected_to new_user_session_url
  end

  test "should get unblinded only category as unblinded user" do
    login(@unblinded)
    get internal_category_url(categories(:unblinded).top_level, categories(:unblinded).slug)
    assert_response :success
  end

  test "should get unblinded only category as editor" do
    login(@editor)
    get internal_category_url(categories(:unblinded).top_level, categories(:unblinded).slug)
    assert_response :success
  end

  test "should not get unblinded only category as blinded viewer" do
    login(@viewer)
    get internal_category_url(categories(:unblinded).top_level, categories(:unblinded).slug)
    assert_redirected_to dashboard_url
  end

  test "should not get unblinded only category as anonymous viewer" do
    get internal_category_url(categories(:unblinded).top_level, categories(:unblinded).slug)
    assert_redirected_to new_user_session_url
  end

  test "should download document as viewer" do
    login(@viewer)
    get internal_category_document_url(categories(:one).top_level, categories(:one).slug, documents(:two))
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_equal File.binread(assigns(:document).document.path), response.body
    assert_response :success
  end

  test "should download PDF as viewer" do
    login(@viewer)
    get internal_category_document_url(categories(:one).top_level, categories(:one).slug, documents(:pdf))
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_equal File.binread(assigns(:document).document.path), response.body
    assert_response :success
  end

  test "should not download document as anonymous user" do
    get internal_category_document_url(categories(:one).top_level, categories(:one).slug, documents(:two))
    assert_redirected_to new_user_session_url
  end

  test "should get video as viewer" do
    login(@viewer)
    get internal_category_video_url(categories(:learn).top_level, categories(:learn).slug, videos(:one))
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:video)
    assert_response :success
  end

  test "should not get video as anonymous viewer" do
    get internal_category_video_url(categories(:learn).top_level, categories(:learn).slug, videos(:one))
    assert_redirected_to new_user_session_url
  end

  test "should get leaving as viewer" do
    login(@viewer)
    get leaving_url(slice: ENV["slice_url"])
    assert_response :success
  end

  test "should get search" do
    login(@viewer)
    get search_url
    assert_response :success
  end
end
