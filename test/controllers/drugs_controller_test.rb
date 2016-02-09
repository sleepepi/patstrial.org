require 'test_helper'

class DrugsControllerTest < ActionController::TestCase
  setup do
    @drug = drugs(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:drugs)
  end

  test 'should show drug' do
    get :show, id: @drug
    assert_response :success
  end
end
