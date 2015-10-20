require 'test_helper'

# Viewers, editors, and admins should be able to see static internal pages
class InternalControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
  end

  test 'should get dashboard as viewer' do
    login(@viewer)
    get :dashboard
    assert_response :success
  end

  test 'should not get dashboard as anonymous user' do
    get :dashboard
    assert_redirected_to new_user_session_path
  end

  test 'should get directory as viewer' do
    login(@viewer)
    get :directory
    assert_response :success
  end

  test 'should not get directory as anonymous user' do
    get :directory
    assert_redirected_to new_user_session_path
  end
end
