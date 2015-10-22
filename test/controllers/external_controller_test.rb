require 'test_helper'

# Static external pages should be publicly viewable
class ExternalControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
  end

  test 'should get contact as anonymouse viewer' do
    login(@viewer)
    get :contact
    assert_response :success
  end

  test 'should get contact as generic viewer' do
    login_viewer(@generic_viewer)
    get :contact
    assert_response :success
  end

  test 'should get contact as viewer' do
    get :contact
    assert_response :success
  end

  test 'should get sites as anonymouse viewer' do
    login(@viewer)
    get :sites
    assert_response :success
  end

  test 'should get sites as generic viewer' do
    login_viewer(@generic_viewer)
    get :sites
    assert_response :success
  end

  test 'should get sites as viewer' do
    get :sites
    assert_response :success
  end
end
