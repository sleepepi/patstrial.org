require 'test_helper'

# Viewers, editors, and admins should be able to see read only committee pages
class CommitteesControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
    @committee = committees(:one)
  end

  test 'should show committee as viewer' do
    login(@viewer)
    get :show, committee: @committee.slug
    assert_not_nil assigns(:committee)
    assert_response :success
  end

  test 'should show committee as generic viewer' do
    login_viewer(@generic_viewer)
    get :show, committee: @committee.slug
    assert_not_nil assigns(:committee)
    assert_response :success
  end

  test 'should not show committee as anonymous viewer' do
    get :show, committee: @committee.slug
    assert_nil assigns(:committee)
    assert_redirected_to new_user_session_path
  end

  test 'should get comittees index as viewer' do
    login(@viewer)
    get :index
    assert_response :success
  end

  test 'should get comittees index as generic viewer' do
    login_viewer(@generic_viewer)
    get :index
    assert_response :success
  end

  test 'should not get comittees index as anonymous user' do
    get :index
    assert_redirected_to new_user_session_path
  end
end
