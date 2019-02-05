# frozen_string_literal: true

require "test_helper"

# Viewers, editors, and admins should be able to see read only committee pages
class CommitteesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
    @committee = committees(:one)
  end

  test "should show committee as viewer" do
    login(@viewer)
    get committee_url(@committee)
    assert_response :success
  end

  test "should not show committee as anonymous viewer" do
    get committee_url(@committee)
    assert_redirected_to new_user_session_path
  end

  test "should get comittees index as viewer" do
    login(@viewer)
    get committees_url
    assert_response :success
  end

  test "should not get comittees index as anonymous user" do
    get committees_url
    assert_redirected_to new_user_session_path
  end
end
